import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class SearchNoteUseCase implements UseCase<List<NoteEntity>, SearchNoteParams> {
  final Repository repository;

  SearchNoteUseCase(this.repository);

  @override
  Future<List<NoteEntity>> call({SearchNoteParams? params}) {
    return repository.searchNotes(params!.query);
  }
}

class SearchNoteParams {
  final String query;

  SearchNoteParams(this.query);
}
