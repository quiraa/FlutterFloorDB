import 'package:flutter/material.dart';
import 'package:flutter_floor/config/routes/screen_routes.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/home_page.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/note/add_note_page.dart';

class RouteConfig {
  PageRoute getPageRoute(Widget? screen, String? routeName) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => screen!,
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.home:
        return getPageRoute(
          const HomePage(),
          ScreenRoutes.home,
        );

      case ScreenRoutes.note:
        final note = settings.arguments as NoteEntity?;
        return getPageRoute(
          AddNotePage(noteId: noteId),
          ScreenRoutes.note,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No Routes Defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
