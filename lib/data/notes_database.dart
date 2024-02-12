import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_floor/data/notes_dao.dart';
import 'package:flutter_floor/model/notes.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'notes_database.g.dart';

@Database(version: 1, entities: [Notes])
abstract class NotesDatabase extends FloorDatabase {
  NotesDao get dao;
}
