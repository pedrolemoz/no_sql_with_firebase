import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:no_sql_with_firebase/app/modules/todo_list/infrastructure/models/todo_item_model.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/todo_item.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/firebase_datasource.dart';

part 'todo_repository_implementation.g.dart';

@Injectable()
class TodoRepositoryImplementation implements TodoRepository {
  final FirebaseDataSource dataSource;

  TodoRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, void>> addNewItemToCollection(TodoItem newItem) async {
    try {
      return right(
        await dataSource.addNewItemToCollection(
          itemModel: TodoItemModel.fromEntity(item: newItem),
          collectionName: 'todo_items',
        ),
      );
    } on FirebaseException {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleItemValueInCollection(
      TodoItem item) async {
    try {
      return right(
        await dataSource.toggleItemValueInCollection(
          itemModel: TodoItemModel.fromEntity(item: item),
          collectionName: 'todo_items',
        ),
      );
    } on FirebaseException {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteItemFromCollection(TodoItem item) async {
    try {
      return right(
        await dataSource.deleteItemFromCollection(
          itemModel: TodoItemModel.fromEntity(item: item),
          collectionName: 'todo_items',
        ),
      );
    } on FirebaseException {
      return left(OperationFailure());
    }
  }

  @override
  Either<Failure, Stream> getAllItemsFromCollection() {
    try {
      return right(dataSource.getAllItemsFromCollection());
    } on FirebaseException {
      return left(OperationFailure());
    }
  }
}
