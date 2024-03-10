import 'package:floor/floor.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';

@dao
abstract class NoteDao {
  @Query(
      "SELECT * FROM notes WHERE title LIKE '%' || :search || '%' OR content LIKE '%' || :search || '%' ORDER BY createdDate")
  Future<List<NoteEntity>> searchNotes(String search);

  @Query('DELETE FROM notes')
  Future<void> deleteAllNotes();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNote(NoteEntity note);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNote(NoteEntity note);

  @delete
  Future<void> deleteNote(NoteEntity note);

  @Query('SELECT * FROM notes ORDER BY createdDate')
  Future<List<NoteEntity>> getNotesOrderByUpdatedDate();
}
