import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_floor/data/dao.dart';
import 'package:flutter_floor/data/entity/employee.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
}
