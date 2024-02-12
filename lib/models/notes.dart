import 'package:floor/floor.dart';

@entity
class Notes {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String content;
  final String dateAdded;

  String? lastUpdate = "";
  String? category = "";
  bool isChecked = false;

  Notes(this.id, this.title, this.content, this.dateAdded, this.lastUpdate,
      this.category);
}
