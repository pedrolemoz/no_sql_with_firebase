import '../models/todo_item_model.dart';

abstract class FirebaseDataSource {
  Stream<dynamic> getAllItemsFromCollection();

  Future<void> addNewItemToCollection({
    TodoItemModel itemModel,
    String collectionName,
  });

  Future<void> deleteItemFromCollection({
    TodoItemModel itemModel,
    String collectionName,
  });

  Future<void> toggleItemValueInCollection({
    TodoItemModel itemModel,
    String collectionName,
  });
}
