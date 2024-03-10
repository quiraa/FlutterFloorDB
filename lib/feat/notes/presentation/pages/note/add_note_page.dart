import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/core/utils/generate_date.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_event.dart';
import 'package:ionicons/ionicons.dart';

class AddNotePage extends StatefulWidget {
  final NoteEntity? note;
  const AddNotePage({Key? key, this.note}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addNotesAppBar(context),
      body: _buildContent(context),
      floatingActionButton: _buildSaveFab(context),
    );
  }

  Widget _buildSaveFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (widget.note == null) {
          final note = NoteEntity(
            title: _titleController.text.toString(),
            content: _contentController.text.toString(),
            createdDate: 'Created: ${Utils.createDate()}',
          );
          BlocProvider.of<NotesBloc>(context).add(SaveNoteEvent(note));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note Saved'),
            ),
          );
        } else {
          final updatedNote = NoteEntity(
            id: widget.note!.id,
            title: _titleController.text.toString(),
            content: _contentController.text.toString(),
            createdDate: 'Updated: ${Utils.createDate()}',
          );
          BlocProvider.of<NotesBloc>(context).add(UpdateNoteEvent(updatedNote));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note Updated'),
            ),
          );
        }
      },
      child: const Icon(Ionicons.save),
    );
  }

  PreferredSizeWidget _addNotesAppBar(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: _titleController,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter title...',
        ),
      ),
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<NotesBloc>(context).add(const GetAllNotesEvent());
          Navigator.of(context).pop();
        },
        icon: const Icon(Ionicons.chevron_back),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: TextField(
        controller: _contentController,
        maxLines: null,
        cursorColor: Colors.black,
        expands: true,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          filled: true,
          hintText: 'Enter notes...',
        ),
      ),
    );
  }
}
