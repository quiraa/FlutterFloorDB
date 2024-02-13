import 'package:floor/floor.dart';
import 'package:flutter_floor/model/notes.dart';

@dao
abstract class NotesDao {
  @Query('SELECT * FROM tbl_notes')
  Future<List<Notes>> getAllNotes();

  @Query('DELETE FROM tbl_notes')
  Future<void> deleteAllNotes();

  @Query('SELECT * FROM tbl_notes WHERE id = :noteId')
  Stream<Notes?> getSingleNote(int noteId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> createNote(Notes notes);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNote(Notes notes);

  @delete
  Future<void> deleteNote(Notes note);

  @Query('SELECT * FROM tbl_notes ORDER BY date')
  Future<List<Notes>> getAllNotesOrderByDate();

  @Query('SELECT * FROM tbl_notes ORDER BY title ASC')
  Future<List<Notes>> getAllNotesOrderByTitle();
}
