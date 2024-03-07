import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'notes')
class NoteEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'title')
  final String? title;

  @ColumnInfo(name: 'content')
  final String? content;

  @ColumnInfo(name: 'createdDate')
  final String? createdDate;

  const NoteEntity({
    this.id,
    this.title,
    this.content,
    this.createdDate,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      content,
      createdDate,
    ];
  }
}
