import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';

abstract class NotesState {
  final String? message;
  final List<NoteEntity>? notes;
  final NoteEntity? note;

  const NotesState({this.note, this.notes, this.message});
}

class NotesLoadingState extends NotesState {
  const NotesLoadingState();
}

class NotesSuccessState extends NotesState {
  const NotesSuccessState(List<NoteEntity> notes) : super(notes: notes);
}

class NotesEmptyState extends NotesState {
  const NotesEmptyState();
}
