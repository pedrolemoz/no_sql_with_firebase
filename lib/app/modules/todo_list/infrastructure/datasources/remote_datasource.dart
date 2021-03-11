import '../models/todo_item_model.dart';

abstract class RemoteDataSource {
  Future<List<TodoItemModel>> getAllItems();
  Future<void> addNewItem(TodoItemModel itemModel);
  Future<void> deleteItem(TodoItemModel itemModel);
  Future<void> toggleItemValue(TodoItemModel itemModel);
}
