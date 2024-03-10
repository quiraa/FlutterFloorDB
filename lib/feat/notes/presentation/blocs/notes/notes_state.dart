import 'package:equatable/equatable.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';

abstract class NotesState extends Equatable {
  final List<NoteEntity>? notes;
  final NoteEntity? note;

  const NotesState({this.note, this.notes});

  @override
  List<Object?> get props => [notes, note];
}

class NotesEmptyState extends NotesState {
  const NotesEmptyState();
}

class NotesSuccessState extends NotesState {
  const NotesSuccessState(List<NoteEntity> notes) : super(notes: notes);
}
