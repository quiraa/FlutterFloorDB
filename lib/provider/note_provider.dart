import 'package:flutter/material.dart';
import 'package:flutter_floor/data/notes_database.dart';
import 'package:flutter_floor/model/notes.dart';

class NotesProvider extends ChangeNotifier {
  List<Notes> _notes = [];
  List<Notes> get notes => _notes;

  Stream<Notes?>? _currentNote;
  Stream<Notes?>? get currentNote => _currentNote;

  Future<NotesDatabase> _createDatabase() async {
    return await $FloorNotesDatabase.databaseBuilder("notes_db.db").build();
  }

  Future<void> getListOfNotes() async {
    final db = await _createDatabase();
    final allNotes = await db.dao.getAllNotes();
    if (allNotes.isNotEmpty) {
      _notes = allNotes;
    }
    notifyListeners();
  }

  Future<void> createNote(Notes notes) async {
    final db = await _createDatabase();
    final createdNote = await db.dao.createNote(notes);
    notifyListeners();
    return createdNote;
  }

  Future<void> updateNote(Notes notes) async {
    final db = await _createDatabase();
    final updatedNote = await db.dao.updateNote(notes);
    notifyListeners();
    return updatedNote;
  }

  Future<void> deleteNote(Notes notes) async {
    final db = await _createDatabase();
    await db.dao.deleteNote(notes);
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    final db = await _createDatabase();
    await db.dao.deleteAllNotes();
    _notes.clear();
    notifyListeners();
  }

  // Future<void> getSingleNoteById(int noteId) async {
  //   final db = await _createDatabase();
  //   final selectedNote = db.dao.getSingleNote(noteId);
  //   _currentNote = selectedNote;
  //   notifyListeners();
  // }
}
