import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';

abstract class NotesEvent {
  final NoteEntity? note;
  final int? noteId;
  final String? query;

  const NotesEvent({
    this.note,
    this.noteId,
    this.query,
  });
}

class SaveNoteEvent extends NotesEvent {
  const SaveNoteEvent(NoteEntity note) : super(note: note);
}

class GetAllNotesEvent extends NotesEvent {
  const GetAllNotesEvent();
}

class DeleteNoteEvent extends NotesEvent {
  const DeleteNoteEvent(NoteEntity note) : super(note: note);
}

class GetNoteEvent extends NotesEvent {
  const GetNoteEvent(int noteId) : super(noteId: noteId);
}

class DeleteAllNoteEvent extends NotesEvent {
  const DeleteAllNoteEvent();
}

class SearchNoteEvent extends NotesEvent {
  const SearchNoteEvent(String query) : super(query: query);
}
