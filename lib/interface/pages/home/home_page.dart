import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_floor/interface/pages/note/note_page.dart';
import 'package:flutter_floor/interface/pages/todo/todo_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(),
          title: const Text('MemoPad Flutter'),
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.note_alt),
                text: 'Note',
              ),
              Tab(
                icon: Icon(Icons.edit_note),
                text: 'Todo',
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [NotePage(), TodoPage()],
        ),
      ),
    );
  }
}
