import 'package:flutter/material.dart';
import 'package:flutter_floor/interface/pages/home/home_page.dart';
import 'package:flutter_floor/provider/note_provider.dart';
import 'package:flutter_floor/provider/todo_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider())
      ],
      child: MaterialApp(
        title: 'MemoPad Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
