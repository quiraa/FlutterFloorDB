import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_floor/data/dao/notes_dao.dart';
import 'package:flutter_floor/data/dao/todo_dao.dart';
import 'package:flutter_floor/model/notes.dart';
import 'package:flutter_floor/model/todo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'notes_database.g.dart';

@Database(version: 1, entities: [Notes, Todo])
abstract class NotesDatabase extends FloorDatabase {
  NotesDao get noteDao;
  TodoDao get todoDao;
}
