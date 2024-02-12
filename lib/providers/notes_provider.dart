import 'package:flutter/foundation.dart';
import 'package:flutter_floor/data/notes_database.dart';
import 'package:flutter_floor/models/notes.dart';

class NotesProvider extends ChangeNotifier {
  List<Notes> _notesList = [];
  List<Notes> get notesList => _notesList;

  Notes? _currentNotes;
  Notes? get currentNotes => _currentNotes;

  Future<NotesDatabase> _createDatabase() async {
    return await $FloorNotesDatabase
        .databaseBuilder('notes_database.db')
        .build();
  }

  Future<void> listOfNotes() async {
    final database = await _createDatabase();
    final dao = await database.dao.getAllNotes();
    debugPrint(dao.length.toString());
    if (dao.isNotEmpty) {
      _notesList = dao;
    }
    notifyListeners();
  }

  Future<void> addNotes(Notes notes) async {
    final database = await _createDatabase();
    final dao = await database.dao.insertNotes(notes);
    notifyListeners();
    return dao;
  }

  Future<void> updateNotes(Notes notes) async {
    final database = await _createDatabase();
    final dao = await database.dao.updateNotes(notes);
    notifyListeners();
    return dao;
  }

  Future<void> getNotes(int id) async {
    final database = await _createDatabase();
    final dao = await database.dao.selectNote(id);
    debugPrint("$dao");
    _currentNotes = dao;
    notifyListeners();
  }

  Future<void> deleteCheckedItems() async {
    final database = await _createDatabase();
    for (var note in _notesList) {
      if (note.isChecked) {
        await database.dao.deleteById(note.id!);
      }
    }

    notifyListeners();
  }

  void clearCurrentNotes() {
    _currentNotes = null;
    notifyListeners();
  }
}
