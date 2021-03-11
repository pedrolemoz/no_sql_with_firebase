import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../entities/todo_item.dart';
import '../repositories/todo_repository.dart';

part 'get_all_items_from_collection.g.dart';

@Injectable()
class GetAllItemsFromCollection
    implements AsyncUsecase<List<TodoItem>, NoParams> {
  final TodoRepository repository;

  GetAllItemsFromCollection(this.repository);

  @override
  Future<Either<Failure, List<TodoItem>>> call(NoParams params) async {
    return await repository.getAllItems();
  }
}
