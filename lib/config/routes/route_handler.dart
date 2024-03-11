import 'package:flutter/material.dart';
import 'package:flutter_floor/config/routes/screen_route.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/home_page.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/note/add_note_page.dart';

class RouteHandler {
  PageRoute getPageRoute({String? routeName, Widget? screen}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => screen!,
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoute.home:
        return getPageRoute(
          routeName: ScreenRoute.home,
          screen: const HomePage(),
        );

      case ScreenRoute.note:
        final note = settings.arguments as NoteEntity?;
        return getPageRoute(
          routeName: ScreenRoute.note,
          screen: AddNotePage(note: note),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Routes Defined For ${settings.name}'),
            ),
          ),
        );
    }
  }
}
