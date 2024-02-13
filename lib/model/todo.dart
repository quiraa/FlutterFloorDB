import 'package:floor/floor.dart';

@Entity(tableName: "todo")
class Todo {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'task')
  String todoTask = 'Empty Task';

  @ColumnInfo(name: 'important')
  bool isImportant = false;

  Todo(this.id, this.todoTask, this.isImportant);
}
