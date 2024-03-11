import 'package:flutter_floor/core/usecases/usecases.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';

class GetAllNotesUseCase implements UseCase<List<NoteEntity>, void> {
  final Repository repository;

  GetAllNotesUseCase(this.repository);

  @override
  Future<List<NoteEntity>> call({void params}) {
    return repository.getAllNotesOrderByDate();
  }
}
