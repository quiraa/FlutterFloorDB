import 'package:flutter/material.dart';
import 'package:flutter_floor/data/notes_database.dart';
import 'package:flutter_floor/model/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<NotesDatabase> _createDatabase() async {
    return await $FloorNotesDatabase.databaseBuilder("notes_db.db").build();
  }

  Future<void> getAllTodos() async {
    final db = await _createDatabase();
    final allTodos = await db.todoDao.getAllTodoOrderByTask();
    if (allTodos.isNotEmpty) {
      _todos = allTodos;
    }
    notifyListeners();
  }

  Future<void> insertTodo(Todo todos) async {
    final db = await _createDatabase();
    final createdTodo = await db.todoDao.createTodo(todos);
    notifyListeners();
    return createdTodo;
  }

  Future<void> updateTodo(Todo todos) async {
    final db = await _createDatabase();
    final updatedTodo = await db.todoDao.updateTodo(todos);
    notifyListeners();
    return updatedTodo;
  }

  Future<void> deleteTodo(Todo todos) async {
    final db = await _createDatabase();
    await db.todoDao.deleteTodo(todos);
    notifyListeners();
  }
}
