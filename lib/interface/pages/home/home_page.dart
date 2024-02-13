import 'package:flutter/material.dart';
import 'package:flutter_floor/data/notes_database.dart';
import 'package:flutter_floor/interface/pages/addnote/add_note_page.dart';
import 'package:flutter_floor/model/notes.dart';
import 'package:flutter_floor/provider/note_provider.dart';
import 'package:flutter_floor/interface/widgets/note_card_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotesProvider _notesProvider;

  @override
  void initState() {
    super.initState();
    // notesProvider = Provider.of<NotesProvider>(context, listen: false);
    // notesProvider.getListOfNotes();
    Future.delayed(const Duration(milliseconds: 0), () async {
      return await _notesProvider.getListOfNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    _notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoPad Flutter'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(notes: null),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, _) {
          return notesProvider.notes.isEmpty
              ? const Center(
                  child: Text('Empty Notes'),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (context, index) {
                    Notes notes = notesProvider.notes[index];
                    return NoteCardItem(
                      notes: notes,
                      onNoteClicked: () => _navigateToEditPage(notes),
                      onNoteDeleted: () => _deleteNoteAndRefreshList(notes),
                    );
                  },
                );
        },
      ),
    );
  }

  Future<void> _deleteNoteAndRefreshList(Notes notes) async {
    await _notesProvider.deleteNote(notes);
    await _notesProvider.getListOfNotes();
  }

  void _navigateToEditPage(Notes notes) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddNotePage(notes: notes);
      }),
    );
  }
}
