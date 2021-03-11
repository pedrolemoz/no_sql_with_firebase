import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../infrastructure/datasources/firebase_datasource.dart';
import '../../infrastructure/models/todo_item_model.dart';

part 'firebase_datasource_implementation.g.dart';

@Injectable()
class FirebaseDataSourceImplementation implements FirebaseDataSource {
  final Firestore firestore;

  FirebaseDataSourceImplementation(this.firestore);

  @override
  Future<void> addNewItemToCollection({
    TodoItemModel itemModel,
    String collectionName,
  }) async =>
      await firestore.collection(collectionName).add(itemModel.toMap());

  @override
  Future<void> toggleItemValueInCollection({
    TodoItemModel itemModel,
    String collectionName,
  }) async {
    final snapshot = await firestore
        .collection(collectionName)
        .where('description', isEqualTo: itemModel.description)
        .getDocuments();

    final documentID = snapshot.documents.first.documentID;

    await firestore
        .collection(collectionName)
        .document(documentID)
        .updateData(itemModel.toMap());
  }

  @override
  Future<void> deleteItemFromCollection({
    TodoItemModel itemModel,
    String collectionName,
  }) async {
    final snapshot = await firestore
        .collection(collectionName)
        .where('description', isEqualTo: itemModel.description)
        .getDocuments();

    final documentID = snapshot.documents.first.documentID;

    await firestore.collection(collectionName).document(documentID).delete();
  }

  @override
  Stream getAllItemsFromCollection() {
    var stream = Firestore.instance
        .collection('todo_items')
        .orderBy('value')
        .orderBy('description')
        .snapshots();

    return stream;
  }
}
