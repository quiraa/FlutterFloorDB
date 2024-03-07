import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class DeleteSingleTodoUseCase implements UseCase<void, TodoEntity> {
  final Repository repository;

  DeleteSingleTodoUseCase(this.repository);

  @override
  Future<void> call({TodoEntity? params}) {
    return repository.deleteSingleTodo(params!);
  }
}
