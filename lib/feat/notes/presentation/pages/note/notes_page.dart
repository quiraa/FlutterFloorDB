import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/config/routes/route_navigator.dart';
import 'package:flutter_floor/config/routes/screen_routes.dart';
import 'package:flutter_floor/config/themes/typography.dart';
import 'package:flutter_floor/di/injection_container.dart';
import 'package:flutter_floor/feat/notes/data/entity/note_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/notes/notes_state.dart';
import 'package:flutter_floor/feat/notes/presentation/widgets/note_card.dart';
import 'package:ionicons/ionicons.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (_) => injection()..add(const GetAllNotesEvent()),
      child: Scaffold(
        body: _buildBody(),
        floatingActionButton: _buildAddNoteFab(context),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case NotesLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case NotesEmptyState:
            return const Center(
              child: Text(
                'Empty Notes, Try To Add One',
                style: AppTypography.noteTitle,
              ),
            );

          case NotesSuccessState:
            return NotesContent(
              notes: state.notes ?? [],
              onNoteClick: (noteId) {},
              onNoteDelete: (note) {},
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildAddNoteFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          RouteNavigator.push(context, ScreenRoutes.note, arguments: null),
      child: const Icon(Ionicons.add),
    );
  }
}

class NotesContent extends StatefulWidget {
  final List<NoteEntity> notes;
  final void Function(int noteId) onNoteClick;
  final void Function(NoteEntity note) onNoteDelete;

  NotesContent({
    Key? key,
    required this.notes,
    required this.onNoteClick,
    required this.onNoteDelete,
  }) : super(key: key);

  @override
  _NotesContentState createState() => _NotesContentState();
}

class _NotesContentState extends State<NotesContent> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (widget.notes.isNotEmpty) {
      case true:
        return AvailableNoteContent(
          notes: widget.notes,
          onNoteClick: widget.onNoteClick,
          onNoteDelete: widget.onNoteDelete,
        );
      case false:
        return const Center(
          child: Text('Emtpy Notes'),
        );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 86,
      automaticallyImplyLeading: false,
      title: TextField(
        controller: _searchController,
        onSubmitted: (currentText) {},
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
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            tooltip: 'Delete All Note',
            onPressed: () {},
            icon: Icon(
              Ionicons.trash_bin,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        )
      ],
    );
  }
}
