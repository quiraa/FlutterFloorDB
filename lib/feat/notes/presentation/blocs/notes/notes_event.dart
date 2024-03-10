import 'package:equatable/equatable.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';

abstract class NotesEvent extends Equatable {
  final NoteEntity? note;
  final String? query;

  const NotesEvent({
    this.note,
    this.query,
  });

  @override
  List<Object?> get props => [note, query];
}

class SaveNoteEvent extends NotesEvent {
  const SaveNoteEvent(NoteEntity note) : super(note: note);
}

class UpdateNoteEvent extends NotesEvent {
  const UpdateNoteEvent(NoteEntity note) : super(note: note);
}

class GetAllNotesEvent extends NotesEvent {
  const GetAllNotesEvent();
}

class DeleteNoteEvent extends NotesEvent {
  const DeleteNoteEvent(NoteEntity note) : super(note: note);
}

class DeleteAllNoteEvent extends NotesEvent {
  const DeleteAllNoteEvent();
}

class SearchNoteEvent extends NotesEvent {
  const SearchNoteEvent(String query) : super(query: query);
}
