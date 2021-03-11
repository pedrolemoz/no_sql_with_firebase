import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../infrastructure/datasources/remote_datasource.dart';
import '../../infrastructure/models/todo_item_model.dart';

part 'firebase_datasource_implementation.g.dart';

@Injectable()
class FirebaseDataSourceImplementation implements RemoteDataSource {
  final Firestore firestore;
  static const _collectionName = 'todo_items';

  FirebaseDataSourceImplementation(this.firestore);

  @override
  Future<void> addNewItem(TodoItemModel itemModel) async =>
      await firestore.collection(_collectionName).add(itemModel.toMap());

  @override
  Future<void> toggleItemValue(TodoItemModel itemModel) async {
    final snapshot = await firestore
        .collection(_collectionName)
        .where('description', isEqualTo: itemModel.description)
        .getDocuments();

    final documentID = snapshot.documents.first.documentID;

    await firestore
        .collection(_collectionName)
        .document(documentID)
        .updateData(itemModel.toMap());
  }

  @override
  Future<void> deleteItem(TodoItemModel itemModel) async {
    final snapshot = await firestore
        .collection(_collectionName)
        .where('description', isEqualTo: itemModel.description)
        .getDocuments();

    final documentID = snapshot.documents.first.documentID;

    await firestore.collection(_collectionName).document(documentID).delete();
  }

  @override
  Future<List<TodoItemModel>> getAllItems() async {
    final items = await Firestore.instance
        .collection('todo_items')
        .orderBy('value')
        .orderBy('description')
        .getDocuments();

    return items.documents
        .map<TodoItemModel>((document) => TodoItemModel.fromMap(document.data))
        .toList();
  }
}
