import 'package:flutter_floor/core/constants/constants.dart';
import 'package:flutter_floor/feat/notes/data/repository/repository_impl.dart';
import 'package:flutter_floor/feat/notes/data/services/local/app_database.dart';
import 'package:flutter_floor/feat/notes/domain/repository/repository.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/delete_all_note_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/delete_note_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/get_all_notes_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/get_note_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/save_notes_usecase.dart';
import 'package:flutter_floor/feat/notes/domain/usecase/notes/search_notes_usecase.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder(Constants.databaseName).build();

  injection.registerSingleton<AppDatabase>(database);

  injection.registerSingleton<Repository>(RepositoryImpl(injection()));

  // * Notes Use Cases
  injection.registerSingleton<GetAllNoteUseCase>(
    GetAllNoteUseCase(injection()),
  );

  injection.registerSingleton<DeleteAllNoteUseCase>(
    DeleteAllNoteUseCase(injection()),
  );

  injection.registerSingleton<DeleteSingleNoteUseCase>(
    DeleteSingleNoteUseCase(injection()),
  );

  injection.registerSingleton<SearchNoteUseCase>(
    SearchNoteUseCase(injection()),
  );

  injection.registerSingleton<SaveNoteUseCase>(
    SaveNoteUseCase(injection()),
  );

  injection.registerSingleton<GetNoteUseCase>(
    GetNoteUseCase(injection()),
  );

  // * BLoCs
  injection.registerFactory<NotesBloc>(
    () => NotesBloc(
      injection(),
      injection(),
      injection(),
      injection(),
      injection(),
    ),
  );
}
