import 'package:flutter/material.dart';
import 'package:flutter_floor/data/notes_database.dart';
import 'package:flutter_floor/model/notes.dart';

class NotesProvider extends ChangeNotifier {
  bool _isSortedByDate = true;
  bool get isSortedByDate => _isSortedByDate;

  void setSortedMode() {
    _isSortedByDate = !_isSortedByDate;
    notifyListeners();
  }

  List<Notes> _notes = [];
  List<Notes> get notes => _notes;

  Stream<Notes?>? _currentNote;
  Stream<Notes?>? get currentNote => _currentNote;

  Future<NotesDatabase> _createDatabase() async {
    return await $FloorNotesDatabase.databaseBuilder("notes_db.db").build();
  }

  Future<void> getAllNotesByDate() async {
    final db = await _createDatabase();
    final sortedNotes = await db.noteDao.getAllNotesOrderByDate();
    if (sortedNotes.isNotEmpty) {
      _notes = sortedNotes;
    }
    notifyListeners();
  }

  Future<void> getAllNotesByTitle() async {
    final db = await _createDatabase();
    final filteredNotes = await db.noteDao.getAllNotesOrderByTitle();
    if (filteredNotes.isNotEmpty) {
      _notes = filteredNotes;
    }
    notifyListeners();
  }

  Future<void> getListOfNotes() async {
    final db = await _createDatabase();
    final allNotes = await db.noteDao.getAllNotes();
    if (allNotes.isNotEmpty) {
      _notes = allNotes;
    }
    notifyListeners();
  }

  Future<void> createNote(Notes notes) async {
    final db = await _createDatabase();
    final createdNote = await db.noteDao.createNote(notes);
    notifyListeners();
    return createdNote;
  }

  Future<void> updateNote(Notes notes) async {
    final db = await _createDatabase();
    final updatedNote = await db.noteDao.updateNote(notes);
    notifyListeners();
    return updatedNote;
  }

  Future<void> deleteNote(Notes notes) async {
    final db = await _createDatabase();
    await db.noteDao.deleteNote(notes);
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    final db = await _createDatabase();
    await db.noteDao.deleteAllNotes();
    _notes.clear();
    notifyListeners();
  }
}
