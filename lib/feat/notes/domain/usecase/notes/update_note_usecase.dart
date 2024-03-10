import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class UpdateNoteUseCase implements UseCase<void, NoteEntity> {
  final Repository repository;

  UpdateNoteUseCase(this.repository);

  @override
  Future<void> call({NoteEntity? params}) {
    return repository.updateNote(params!);
  }
}
