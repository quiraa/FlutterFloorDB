import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class SaveTodoUseCase implements UseCase<void, TodoEntity> {
  final Repository repository;

  SaveTodoUseCase(this.repository);

  @override
  Future<void> call({TodoEntity? params}) {
    return repository.insertTodo(params!);
  }
}
