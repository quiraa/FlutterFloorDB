import 'package:equatable/equatable.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';

abstract class TodosState extends Equatable {
  final List<TodoEntity>? todos;
  final TodoEntity? todo;

  const TodosState({this.todo, this.todos});

  @override
  List<Object?> get props => [todos, todo];
}

class TodosEmptyState extends TodosState {
  const TodosEmptyState();
}

class TodoSuccessState extends TodosState {
  const TodoSuccessState(List<TodoEntity> todos) : super(todos: todos);
}
