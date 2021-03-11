import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../entities/todo_item.dart';
import '../repositories/todo_repository.dart';

part 'delete_item_from_collection.g.dart';

@Injectable()
class DeleteItemFromCollection implements AsyncUsecase<void, TodoItem> {
  final TodoRepository repository;

  DeleteItemFromCollection(this.repository);

  @override
  Future<Either<Failure, void>> call(TodoItem item) async {
    if (item.description.isNotEmpty &&
        item.description != null &&
        item.description != '') {
      return await repository.deleteItem(item);
    } else {
      return left(InvalidItemFailure());
    }
  }
}
