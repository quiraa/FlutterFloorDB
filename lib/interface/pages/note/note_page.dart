import 'package:flutter/material.dart';
import 'package:flutter_floor/constants/colors.dart';
import 'package:flutter_floor/constants/typography.dart';
import 'package:flutter_floor/interface/pages/addnote/add_note_page.dart';
import 'package:flutter_floor/interface/widgets/note_card_item.dart';
import 'package:flutter_floor/model/notes.dart';
import 'package:flutter_floor/provider/note_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late NotesProvider _notesProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () async {
      return await _notesProvider.getAllNotesByDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    _notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: 'Delete All',
          onPressed: () {
            _notesProvider.deleteAllNotes();
          },
          icon: SvgPicture.asset(
            'assets/trash-2.svg',
            color: deleteIconColor,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Sort Notes',
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/filter.svg',
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
      body: Consumer<NotesProvider>(builder: (context, notesProvider, _) {
        if (notesProvider.notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/wind.svg',
                  width: 86.0,
                  height: 86.0,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Empty Notes',
                  style: AppTypography.dialogTitle,
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              Notes notes = notesProvider.notes[index];
              return NoteCardItem(
                notes: notes,
                onNoteClicked: () {
                  _navigateToEditPage(notes);
                },
                onNoteDeleted: () {
                  _deleteNoteAndRefreshList(notes);
                  setState(() {});
                },
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Notes',
        child: SvgPicture.asset('assets/plus.svg'),
        onPressed: () {
          _navigateToAddNotePage();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _deleteNoteAndRefreshList(Notes notes) async {
    await _notesProvider.deleteNote(notes);
    return await _notesProvider.getListOfNotes();
  }

  void _navigateToEditPage(Notes notes) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddNotePage(notes: notes);
      }),
    );
  }

  void _navigateToAddNotePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNotePage(notes: null),
      ),
    );
  }
}
