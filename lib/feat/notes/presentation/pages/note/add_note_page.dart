import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/config/routes/route_navigator.dart';
import 'package:flutter_floor/core/utils/generate_date.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_state.dart';

class AddNotePage extends StatelessWidget {
  final int? noteId;

  const AddNotePage({
    Key? key,
    this.noteId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (noteId == null) {
      return const AddNoteContent();
    } else {
      return BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return AddNoteContent(
            note: state.note,
          );
        },
      );
    }
  }
}

class AddNoteContent extends StatefulWidget {
  final NoteEntity? note;
  const AddNoteContent({Key? key, this.note}) : super(key: key);

  @override
  _AddNoteContentState createState() => _AddNoteContentState();
}

class _AddNoteContentState extends State<AddNoteContent> {
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
  void dispose() {
    super.dispose();

    BlocProvider.of<NotesBloc>(context).add(const GetAllNotesEvent());
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
        final note = NoteEntity(
          title: _titleController.text,
          content: _contentController.text,
          createdDate: Utils.createDate(),
        );
        BlocProvider.of<NotesBloc>(context).add(
          SaveNoteEvent(note),
        );
        Navigator.of(context).pop();
      },
      child: const Icon(Icons.save_rounded),
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
        onPressed: () => RouteNavigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
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
