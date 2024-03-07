import 'package:floor/floor.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/data/services/local/dao/note_dao.dart';
import 'package:flutter_floor/feat/notes/data/services/local/dao/todo_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

@Database(version: 1, entities: [NoteEntity, TodoEntity])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
  TodoDao get todoDao;
}
