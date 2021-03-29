import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:yaxxxta/logic/core/models.dart';
import 'utils/list.dart';

/// Создает Firebase батч - типа транзакция
/// Обычно используется это: FirebaseFirestore.instance.batch
typedef CreateBatch = WriteBatch Function();

/// Firebase / Firestore репо
abstract class FirebaseRepo<T extends WithExternalId>
    with WithInsertOrUpdateManyByExternalId<T> {
  /// Фаерстор коллекция
  @protected
  final CollectionReference collectionReference;

  /// Создает Firebase батч - типа транзакция
  @protected
  final CreateBatch createBatch;

  /// Firebase Firestore репо
  FirebaseRepo({
    required this.collectionReference,
    required this.createBatch,
  });

  /// Конвертит сущность в фаерстор формат
  @protected
  Map<String, dynamic> entityToFirebase(T entity);

  /// Создает сущность из фаерстор дока
  @protected
  T entityFromFirebase(DocumentSnapshot doc);

  /// Вставляет сущность в фаерстор
  Future<String> insert(T entity) async =>
      (await collectionReference.add(entityToFirebase(entity))).id;

  /// Обновляет сущность в фаерстор
  Future<void> update(T entity) =>
      collectionReference.doc(entity.id).update(entityToFirebase(entity));

  /// Удаляет сущность в фаерстор по айди
  Future<void> deleteById(String id) => collectionReference.doc(id).delete();

  /// Получает сущность из фаерстор по айди
  Future<T> get(String id) async =>
      entityFromFirebase((await collectionReference.doc(id).get()));

  /// Получает сущности из фаерстор по айди
  Future<List<T>> listByIds(List<String> ids) async =>
      (await listDocsByIds(ids)).map(entityFromFirebase).toList();

  /// Получает документы по айди
  @protected
  Future<Iterable<QueryDocumentSnapshot>> listDocsByIds(
    List<String> ids, {
    String? idField,
  }) async {
    if (ids.isEmpty) return [];

    return (await Future.wait(
      /// whereIn робит ток для списков длиной 10 =>
      /// режем список на списки по 10 + запрашиваем данные асинхронно
      ids.chunked(size: 10).map(
            (idsChunk) => collectionReference
                .where(idField ?? FieldPath.documentId, whereIn: idsChunk)
                .get(),
          ),
    ))
        .expand((qs) => qs.docs);
  }

  @override
  Future<List<T>> getAllByExternalIds(List<String> externalIds) async =>
      (await listDocsByIds(externalIds, idField: "externalId"))
          .map(entityFromFirebase)
          .toList();

  @override
  Future<void> updateMany(List<T> entities) async {
    var batch = createBatch();

    for (var entity in entities) {
      batch.update(
        collectionReference.doc(entity.id),
        entityToFirebase(entity),
      );
    }

    await batch.commit();
  }

  @override
  Future<List<String>> insertMany(List<T> entities) async {
    var ids = <String>[];

    var batch = createBatch();

    for (var entity in entities) {
      var doc = collectionReference.doc();
      batch.set(doc, entityToFirebase(entity));
      ids.add(doc.id);
    }

    await batch.commit();
    return ids;
  }
}

/// Базовый класс для хайв репозиториев
abstract class HiveRepo<T extends WithExternalId>
    with WithInsertOrUpdateManyByExternalId<T> {
  /// Хайв коробка (типа табличка)
  @visibleForTesting
  @protected
  final Box<Map> box;
  final Uuid _uuid = Uuid();

  /// Базовый класс для хайв репозиториев
  HiveRepo(this.box);

  /// Вставляет в бд
  Future<String> insert(T entity) async {
    var id = _uuid.v1();
    await box.put(id, entityToHive(entity));
    return id;
  }

  /// Обновляет в бд
  Future<void> update(T entity) async {
    await box.put(entity.id, entityToHive(entity));
  }

  /// Удаляет по айди в бд
  Future<void> deleteById(String id) => box.delete(id);

  /// Конвертит сущность в хайв словарик
  @protected
  Map entityToHive(T entity);

  /// Создает сущность из хайв словарика
  @protected
  T entityFromHive(String id, Map hiveData);

  @override
  Future<List<String>> insertMany(List<T> entities) async {
    var ids = entities.map((e) => _uuid.v1()).toList();
    await box.putAll(Map<String, Map>.fromIterables(
      ids,
      entities.map(entityToHive),
    ));
    return ids;
  }

  @override
  Future<void> updateMany(List<T> entities) async {
    var ids = entities.map((e) => e.id!).toList();
    await box.putAll(Map<String, Map>.fromIterables(
      ids,
      entities.map(entityToHive),
    ));
  }

  @override
  Future<List<T>> getAllByExternalIds(List<String> externalIds) async => box
      .toMap()
      .entries
      .map((e) => entityFromHive(e.key as String, e.value))
      .where((e) => externalIds.contains(e.externalId))
      .toList();
}

/// Вставляет или обновляет сущности по [externalId].
mixin WithInsertOrUpdateManyByExternalId<T extends WithExternalId> {
  /// Получает все сущности с [externalId] из [externalIds]
  @protected
  Future<List<T>> getAllByExternalIds(List<String> externalIds);

  /// Вставляет несколько сущностей
  @protected
  Future<List<String>> insertMany(List<T> entities);

  /// Обновляет несколько сущностей
  @protected
  Future<void> updateMany(List<T> entities);

  /// Вставляет или обновляет сущности по [externalId]
  /// Возвращает список айди, как новых, так и старых
  /// Порядок совпадает с [entities]
  Future<List<String>> insertOrUpdateManyByExternalId(List<T> entities) async {
    // Ищем в бд все сущности с [externalId]
    var externalIds = List<String>.from(
      entities.map((e) => e.externalId).where((id) => id != null),
    );
    var existingEntitiesMap = Map<String, T>.fromEntries(
      (await getAllByExternalIds(externalIds))
          .map((e) => MapEntry<String, T>(e.externalId!, e)),
    );

    // Распределяем [entities] на те, которые есть в [existingEntitiesMap], и
    // на те, которых нет; а также создаем массив айдишек,
    // в котором null обозначает, что сущности нет в бд => нет айди
    var entitiesToUpdate = <T>[];
    var entitiesToInsert = <T>[];
    var ids = <String?>[];

    for (var e in entities) {
      if (existingEntitiesMap.containsKey(e.externalId)) {
        entitiesToUpdate.add(existingEntitiesMap[e.externalId]!);
        ids.add(e.id!);
      } else {
        entitiesToInsert.add(e);
        ids.add(null);
      }
    }

    // Вставляем сущности, которых нет в бд + обновляем те, что есть
    var results = await Future.wait([
      insertMany(entitiesToInsert),
      updateMany(entitiesToUpdate),
    ]);

    // Проставляем в [ids] вместо null айди,
    // котороые получили после вставки в бд
    var insertIds = Queue.of(results[0] as List<String>);
    for (var i in List.generate(ids.length, (index) => index)) {
      if (ids[i] == null) {
        ids[i] = insertIds.removeFirst();
      }
    }

    return List<String>.from(ids);
  }
}
