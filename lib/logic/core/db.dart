import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:yaxxxta/logic/core/models.dart';
import 'utils/list.dart';

/// Firebase / Firestore репо
abstract class FirebaseRepo<T extends WithId> {
  /// Фаерстор коллекция
  @protected
  final CollectionReference collectionReference;

  /// Firebase Firestore репо
  FirebaseRepo(this.collectionReference);

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
}

/// Базовый класс для хайв репозиториев
abstract class HiveRepo<T extends WithId> {
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

  /// Вставляет несколько сущностей
  Future<List<String>> insertMany(List<T> entities) async {
    var ids = entities.map((e) => _uuid.v1()).toList();
    await box.putAll(Map<String, Map>.fromIterables(
      ids,
      entities.map(entityToHive),
    ));
    return ids;
  }

  /// Обновляет несколько сущностей
  Future<void> updateMany(List<T> entities) async {
    var ids = entities.map((e) => e.id!).toList();
    await box.putAll(Map<String, Map>.fromIterables(
      ids,
      entities.map(entityToHive),
    ));
  }
}

/// Вставляет или обновляет сущности по [externalId].
mixin WithInsertOrUpdateManyByExternalId<T extends WithExternalId>
    on HiveRepo<T> {
  /// Вставляет или обновляет сущности по [externalId]
  /// Возвращает список айди, как новых, так и старых
  /// Порядок совпадает с [entities]
  Future<List<String>> insertOrUpdateManyByExternalId(List<T> entities) async {
    // Ищем в бд все сущности с [externalId]
    var externalIds =
        entities.map((e) => e.externalId).where((id) => id != null).toList();
    var existingEntitiesMap = Map<String, T>.fromEntries(
      box
          .toMap()
          .entries
          .map((e) => entityFromHive(e.key as String, e.value))
          .where((e) => externalIds.contains(e.externalId))
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
