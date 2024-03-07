import 'package:floor/floor.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM notes WHERE id = :noteId')
  Stream<NoteEntity?> getSingleNote(int noteId);

  @Query(
      'SELECT * FROM notes WHERE title LIKE :query OR content LIKE :query ORDER BY updatedDate')
  Future<List<NoteEntity>> searchNotes(String query);

  @Query('DELETE FROM notes')
  Future<void> deleteAllNotes();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNote(NoteEntity note);

  @delete
  Future<void> deleteNote(NoteEntity note);

  @Query('SELECT * FROM notes ORDER BY updatedDate')
  Future<List<NoteEntity>> getNotesOrderByUpdatedDate();
}
