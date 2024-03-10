import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/config/themes/typography.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_state.dart';
import 'package:flutter_floor/feat/notes/presentation/pages/note/add_note_page.dart';
import 'package:flutter_floor/feat/notes/presentation/widgets/note_card.dart';
import 'package:ionicons/ionicons.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesBloc>(context).add(const GetAllNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildAddNoteFab(context),
    );
  }

  _buildBody() {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case NotesEmptyState:
            return const Center(
              child: Text('Empty Notes, Try To Add One'),
            );

          case NotesSuccessState:
            return NotesContent(
              notes: state.notes ?? [],
              onNotesClick: (note) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddNotePage(note: note),
                  ),
                );
              },
              onNoteDelete: (note) {
                BlocProvider.of<NotesBloc>(context).add(
                  DeleteNoteEvent(note),
                );
              },
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildAddNoteFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddNotePage(
              note: null,
            ),
          ),
        );
      },
      child: const Icon(Ionicons.add),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 86,
      automaticallyImplyLeading: false,
      title: TextField(
        controller: _searchController,
        onSubmitted: (query) => _searchNotes(query),
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintText: 'Search notes',
          prefixIcon: IconButton(
            onPressed: () {
              _searchNotes(_searchController.text);
            },
            icon: const Icon(Ionicons.search),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            tooltip: 'Filter',
            onPressed: () {
              BlocProvider.of<NotesBloc>(context).add(
                const DeleteAllNoteEvent(),
              );
            },
            icon: const Icon(Ionicons.filter),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            tooltip: 'Delete All ',
            onPressed: () {
              BlocProvider.of<NotesBloc>(context).add(
                const DeleteAllNoteEvent(),
              );
            },
            icon: Icon(
              Ionicons.trash_bin,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        )
      ],
    );
  }

  void _searchNotes(String query) {
    BlocProvider.of<NotesBloc>(context).add(SearchNoteEvent(query));
  }
}

class NotesContent extends StatefulWidget {
  final List<NoteEntity> notes;
  final void Function(NoteEntity note) onNotesClick;
  final void Function(NoteEntity note) onNoteDelete;

  const NotesContent({
    Key? key,
    required this.notes,
    required this.onNotesClick,
    required this.onNoteDelete,
  }) : super(key: key);

  @override
  _NotesContentState createState() => _NotesContentState();
}

class _NotesContentState extends State<NotesContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (widget.notes.isNotEmpty) {
      case true:
        return AvailableNoteContent(
          notes: widget.notes,
          onNoteClick: widget.onNotesClick,
          onNoteDelete: widget.onNoteDelete,
        );

      case false:
        return const Center(
          child: Text(
            'Empty Note, Try to Create One',
            style: AppTypography.noteDate,
          ),
        );
    }
  }
}
