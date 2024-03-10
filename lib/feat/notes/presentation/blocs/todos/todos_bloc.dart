import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/todos/delete_all_todos_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/todos/delete_todo_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/todos/get_all_todos_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/todos/save_todos_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/todos/update_todo_usecase.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final UpdateTodoUseCase updateTodoUseCase;
  final SaveTodoUseCase saveTodoUseCase;
  final GetAllTodoUseCase getAllTodoUseCase;
  final DeleteAllTodoUseCase deleteAllTodoUseCase;
  final DeleteSingleTodoUseCase deleteSingleTodoUseCase;

  TodosBloc(
    this.deleteAllTodoUseCase,
    this.deleteSingleTodoUseCase,
    this.getAllTodoUseCase,
    this.saveTodoUseCase,
    this.updateTodoUseCase,
  ) : super(const TodosEmptyState()) {
    on<UpdateTodoEvent>(onUpdateTodo);
    on<DeleteTodoEvent>(onDeleteTodo);
    on<DeleteAllTodoEvent>(onDeleteAllTodo);
    on<GetAllTodoEvent>(onGetAllTodo);
    on<SaveTodoEvent>(onSaveTodo);
  }

  void onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodosState> emit,
  ) async {
    await updateTodoUseCase(params: event.todo!);
    final currentTodos = await getAllTodoUseCase();
    emit(TodoSuccessState(currentTodos));
  }

  void onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodosState> emit,
  ) async {
    await deleteSingleTodoUseCase(params: event.todo!);
    final currentTodoss = await getAllTodoUseCase();
    emit(TodoSuccessState(currentTodoss));
  }

  void onDeleteAllTodo(
    DeleteAllTodoEvent event,
    Emitter<TodosState> emit,
  ) async {
    await deleteAllTodoUseCase();
    final currentTodos = await getAllTodoUseCase();
    emit(TodoSuccessState(currentTodos));
  }

  void onGetAllTodo(
    GetAllTodoEvent event,
    Emitter<TodosState> emit,
  ) async {
    final allTodos = await getAllTodoUseCase();
    emit(TodoSuccessState(allTodos));
  }

  void onSaveTodo(
    SaveTodoEvent event,
    Emitter<TodosState> emit,
  ) async {
    await saveTodoUseCase(params: event.todo!);
    final currentTodos = await getAllTodoUseCase();
    emit(TodoSuccessState(currentTodos));
  }
}
