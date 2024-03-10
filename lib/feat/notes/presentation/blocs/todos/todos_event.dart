import 'package:equatable/equatable.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';

abstract class TodosEvent extends Equatable {
  final TodoEntity? todo;

  const TodosEvent({this.todo});

  @override
  List<Object?> get props => [todo];
}

class GetAllTodoEvent extends TodosEvent {
  const GetAllTodoEvent();
}

class UpdateTodoEvent extends TodosEvent {
  const UpdateTodoEvent(TodoEntity todo) : super(todo: todo);
}

class SaveTodoEvent extends TodosEvent {
  const SaveTodoEvent(TodoEntity todo) : super(todo: todo);
}

class DeleteAllTodoEvent extends TodosEvent {
  const DeleteAllTodoEvent();
}

class DeleteTodoEvent extends TodosEvent {
  const DeleteTodoEvent(TodoEntity todo) : super(todo: todo);
}
