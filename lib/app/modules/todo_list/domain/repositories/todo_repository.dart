import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../entities/todo_item.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoItem>>> getAllItems();
  Future<Either<Failure, void>> addNewItem(TodoItem newItem);
  Future<Either<Failure, void>> deleteItem(TodoItem item);
  Future<Either<Failure, void>> toggleItemValue(TodoItem item);
}
