import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'todos')
class TodoEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'task')
  final String? task;

  @ColumnInfo(name: 'isImportant')
  final bool? isImportant;

  const TodoEntity({
    this.id,
    this.task,
    this.isImportant,
  });

  @override
  List<Object?> get props {
    return [
      id,
      task,
      isImportant,
    ];
  }
}
