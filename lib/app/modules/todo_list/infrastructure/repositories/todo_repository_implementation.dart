import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/todo_item.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/remote_datasource.dart';
import '../models/todo_item_model.dart';

part 'todo_repository_implementation.g.dart';

@Injectable()
class TodoRepositoryImplementation implements TodoRepository {
  final RemoteDataSource dataSource;

  TodoRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, void>> addNewItem(TodoItem newItem) async {
    try {
      return right(
        await dataSource.addNewItem(TodoItemModel.fromEntity(item: newItem)),
      );
    } on DataSourceException {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleItemValue(TodoItem item) async {
    try {
      return right(
        await dataSource.toggleItemValue(
          TodoItemModel.fromEntity(item: item),
        ),
      );
    } on DataSourceException {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteItem(TodoItem item) async {
    try {
      return right(
        await dataSource.deleteItem(
          TodoItemModel.fromEntity(item: item),
        ),
      );
    } on DataSourceException {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoItem>>> getAllItems() async {
    try {
      return right(await dataSource.getAllItems());
    } on DataSourceException {
      return left(OperationFailure());
    }
  }
}
