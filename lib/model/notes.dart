import 'package:floor/floor.dart';

@Entity(tableName: "tbl_notes")
class Notes {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: "title")
  String noteTitle;

  @ColumnInfo(name: "content")
  String noteContent;

  @ColumnInfo(name: "date")
  String noteDate;

  Notes(this.id, this.noteTitle, this.noteContent, this.noteDate);
}
