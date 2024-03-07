import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class DeleteAllTodoUseCase implements UseCase<void, void> {
  final Repository repository;

  DeleteAllTodoUseCase(this.repository);

  @override
  Future<void> call({void params}) {
    return repository.deleteAllTodo();
  }
}
