import 'package:flutter/material.dart';
import 'package:flutter_floor/model/notes.dart';
import 'package:flutter_floor/provider/note_provider.dart';
import 'package:flutter_floor/utils/generate_date.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  final Notes? notes;
  const AddNotePage({Key? key, required this.notes}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late NotesProvider notesProvider;
  late TextEditingController titleController;
  late TextEditingController contentController;

  Future<void> createNote() async {
    Notes notes = Notes(
      null,
      titleController.text.toString(),
      contentController.text.toString(),
      createDate(),
    );
    await notesProvider.createNote(notes);
  }

  Future<void> updateNote() async {
    widget.notes!.noteTitle = titleController.text;
    widget.notes!.noteContent = contentController.text;
    await notesProvider.updateNote(widget.notes!);
  }

  @override
  void dispose() {
    super.dispose();
    Future.delayed(const Duration(milliseconds: 0), () {
      return notesProvider.getListOfNotes();
    });
  }

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.notes?.noteTitle ?? '');
    contentController =
        TextEditingController(text: widget.notes?.noteContent ?? '');
  }

  @override
  Widget build(BuildContext context) {
    notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: _addNotesAppBar(context),
      body: _buildUI(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.notes != null) {
            updateNote();
          } else {
            createNote();
          }
          Navigator.pop(context);
        },
        child: SvgPicture.asset('assets/save.svg'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _addNotesAppBar(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: titleController,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: 'Enter title...'),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

  Widget _buildUI(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: TextField(
        controller: contentController,
        maxLines: null,
        cursorColor: Colors.black,
        expands: true,
        keyboardType: TextInputType.multiline,
        decoration:
            const InputDecoration(filled: true, hintText: 'Enter notes...'),
      ),
    );
  }
}
