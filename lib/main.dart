import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/config/routes/route_handler.dart';
import 'package:flutter_floor/config/routes/screen_route.dart';
import 'package:flutter_floor/config/themes/themes.dart';
import 'package:flutter_floor/di/injection_container.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_event.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/home_page.dart';
import 'package:flutter_floor/feat/notes/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<NotesBloc>(
              create: (context) => injection()..add(const GetAllNotesEvent()),
            ),
            BlocProvider<TodosBloc>(
              create: (context) => injection()..add(const GetAllTodoEvent()),
            )
          ],
          child: MaterialApp(
            title: 'MemoPad Flutter',
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
            themeMode: provider.themeMode,
            darkTheme: AppTheme.darkTheme(),
            theme: AppTheme.lightTheme(),
            initialRoute: ScreenRoute.home,
            onGenerateRoute: RouteHandler().onGenerateRoute,
          ),
        );
      },
    );
  }
}
