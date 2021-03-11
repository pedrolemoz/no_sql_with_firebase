import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../entities/todo_item.dart';
import '../repositories/todo_repository.dart';

part 'add_new_item_to_collection.g.dart';

@Injectable()
class AddNewItemToCollection implements AsyncUsecase<void, TodoItem> {
  final TodoRepository repository;

  AddNewItemToCollection(this.repository);

  @override
  Future<Either<Failure, void>> call(TodoItem newItem) async {
    if (newItem.description.isNotEmpty &&
        newItem.description != null &&
        newItem.description != '') {
      return await repository.addNewItem(newItem);
    } else {
      return left(InvalidItemFailure());
    }
  }
}
