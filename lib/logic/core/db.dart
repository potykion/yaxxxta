
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/logic/core/models.dart';
import 'utils/list.dart';

/// Создает Firebase батч - типа транзакция
/// Обычно используется это: FirebaseFirestore.instance.batch
typedef CreateBatch = WriteBatch Function();

/// Firebase / Firestore репо
abstract class FirebaseRepo<T extends WithId> {
  /// Фаерстор коллекция
  @protected
  @visibleForTesting
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
  @override
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
  Future<List<T>> listByExternalIds(List<String> externalIds) async =>
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
