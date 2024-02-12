import 'package:floor/floor.dart';
import 'package:flutter_floor/data/notes_dao.dart';
import 'package:flutter_floor/models/notes.dart';

part 'notes_database.g.dart';

@Database(version: 1, entities: [Notes])
abstract class NotesDatabase {
  NotesDao get dao;
}
