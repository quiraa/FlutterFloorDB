import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/data/services/local/app_database.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final AppDatabase database;

  RepositoryImpl(this.database);

  @override
  Future<void> deleteAllNote() async {
    return database.noteDao.deleteAllNotes();
  }

  @override
  Future<void> deleteAllTodo() async {
    return database.todoDao.deleteAllTodos();
  }

  @override
  Future<void> deleteSingleNote(NoteEntity note) async {
    return database.noteDao.deleteNote(note);
  }

  @override
  Future<void> deleteSingleTodo(TodoEntity todo) async {
    return database.todoDao.deleteTodo(todo);
  }

  @override
  Future<List<NoteEntity>> getAllNotesOrderByDate() async {
    return database.noteDao.getNotesOrderByUpdatedDate();
  }

  @override
  Future<List<TodoEntity>> getAllTodos() {
    // TODO: implement getAllTodos
    throw UnimplementedError();
  }

  @override
  Stream<NoteEntity?> getSingleNote(int noteId) {
    return database.noteDao.getSingleNote(noteId);
  }

  @override
  Future<void> insertNote(NoteEntity note) async {
    return database.noteDao.insertNote(note);
  }

  @override
  Future<void> insertTodo(TodoEntity todo) async {
    return database.todoDao.createTodo(todo);
  }

  @override
  Future<List<NoteEntity>> searchNotes(String query) async {
    return database.noteDao.searchNotes(query);
  }
}
