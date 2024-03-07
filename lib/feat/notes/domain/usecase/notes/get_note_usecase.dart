import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class GetNoteUseCase {
  final Repository repository;

  GetNoteUseCase(this.repository);

  Stream<NoteEntity?> call({int? params}) {
    return repository.getSingleNote(params!);
  }
}
