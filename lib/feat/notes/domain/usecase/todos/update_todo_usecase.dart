import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class UpdateTodoUseCase implements UseCase<void, TodoEntity> {
  final Repository repository;

  UpdateTodoUseCase(this.repository);

  @override
  Future<void> call({TodoEntity? params}) {
    return repository.updateTodo(params!);
  }
}
