import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).getListOfNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildUI(context),
      floatingActionButton: _fabAddNotes(
        onAddNote: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddNotePage(notes: null)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text('MemoPadFlutter'),
    );
  }

  Widget _buildUI(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    if (notesProvider.notes.isEmpty) {
      return const Center(
        child: Text('Tidak ada catatan yang tersedia'),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: notesProvider.notes.length,
      itemBuilder: (context, index) {
        Notes notes = notesProvider.notes[index];
        return NoteCardItem(
          notes: notesProvider.notes[index],
          onNoteClicked: () {
            int noteId = notes.id ?? 0;
            notesProvider.getSingleNoteById(noteId);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNotePage(notes: notes)),
            );
          },
          onNoteDeleted: () {
            notesProvider.deleteNote(notes);
          },
        );
      },
    );
  }

  Widget _fabAddNotes({required Function onAddNote}) {
    return FloatingActionButton(
      onPressed: () => onAddNote,
      child: const Icon(Icons.add),
    );
  }
}
