import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/delete_all_note_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/delete_note_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/save_notes_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/search_notes_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/get_all_notes_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/update_note_usecase.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final DeleteAllNoteUseCase deleteAllNoteUseCase;
  final DeleteSingleNoteUseCase deleteSingleNoteUseCase;
  final GetAllNotesUseCase getAllNotesUseCase;
  final SaveNoteUseCase saveNoteUseCase;
  final SearchNoteUseCase searchNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  NotesBloc(
    this.deleteAllNoteUseCase,
    this.deleteSingleNoteUseCase,
    this.saveNoteUseCase,
    this.searchNoteUseCase,
    this.updateNoteUseCase,
    this.getAllNotesUseCase,
  ) : super(const NotesEmptyState()) {
    on<DeleteAllNoteEvent>(onDeleteAllNote);
    on<SearchNoteEvent>(onSearchNote);
    on<DeleteNoteEvent>(onDeleteNote);
    on<GetAllNotesEvent>(onGetAllNotes);
    on<SaveNoteEvent>(onSaveNote);
    on<UpdateNoteEvent>(onUpdateNote);
  }

  void onUpdateNote(
    UpdateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    await updateNoteUseCase(params: event.note);
    final currentNotes = await getAllNotesUseCase();
    emit(NotesSuccessState(currentNotes));
  }

  void onSaveNote(
    SaveNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    await saveNoteUseCase(params: event.note);
    final currentNotes = await getAllNotesUseCase();
    emit(NotesSuccessState(currentNotes));
  }

  void onGetAllNotes(
    GetAllNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    final allNotes = await getAllNotesUseCase();
    emit(NotesSuccessState(allNotes));
  }

  void onDeleteAllNote(
    DeleteAllNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    await deleteAllNoteUseCase();
    final currentNotes = await getAllNotesUseCase();
    emit(NotesSuccessState(currentNotes));
  }

  void onSearchNote(
    SearchNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    if (event.query!.isNotEmpty) {
      final searchResult = await searchNoteUseCase(
        params: SearchNoteParams(event.query ?? ''),
      );
      emit(SearchResultState(searchResult));
    } else {
      final notes = await getAllNotesUseCase();
      emit(NotesSuccessState(notes));
    }
  }

  void onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    await deleteSingleNoteUseCase(params: event.note);
    final currentNotes = await getAllNotesUseCase();
    emit(NotesSuccessState(currentNotes));
  }
}
