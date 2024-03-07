import 'package:flutter/material.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/note/notes_page.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/settings_page.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/todo/todo_page.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions[_selectedIndex],
      bottomNavigationBar: _buildNavbar(),
    );
  }

  Widget _buildNavbar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Ionicons.documents),
          icon: Icon(Ionicons.documents_outline),
          label: 'Note',
        ),
        NavigationDestination(
          selectedIcon: Icon(Ionicons.list),
          icon: Icon(Ionicons.list_outline),
          label: 'Todo',
        ),
        NavigationDestination(
          selectedIcon: Icon(Ionicons.settings),
          icon: Icon(Ionicons.settings_outline),
          label: 'Settings',
        ),
      ],
      onDestinationSelected: _onItemTapped,
    );
  }

  static const List<Widget> _screenOptions = <Widget>[
    NotesPage(),
    TodoPage(),
    SettingsPage()
  ];
}
