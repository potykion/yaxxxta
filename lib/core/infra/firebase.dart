import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/core/domain/models.dart';
import '../utils/list.dart';

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
      (await _listDocsByIds(ids)).map(entityFromFirebase).toList();

  /// Получает документы по айди
  Future<Iterable<QueryDocumentSnapshot>> _listDocsByIds(
    List<String> ids,
  ) async {
    if (ids.isEmpty) return [];

    return (await Future.wait(
      /// whereIn робит ток для списков длиной 10 =>
      /// режем список на списки по 10 + запрашиваем данные асинхронно
      ids.chunked(size: 10).map(
            (idsChunk) => collectionReference
                .where(FieldPath.documentId, whereIn: idsChunk)
                .get(),
          ),
    ))
        .expand((qs) => qs.docs);
  }
}
