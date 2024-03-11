// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/config/themes/typography.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_event.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_state.dart';
import 'package:flutter_floor/feat/notes/presentation/widgets/todo_card.dart';
import 'package:flutter_floor/feat/notes/presentation/widgets/todo_dialog.dart';
import 'package:ionicons/ionicons.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodosBloc>(context).add(const GetAllTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case TodosEmptyState:
            return const SizedBox();

          case TodoSuccessState:
            return TodoContent(
              todos: state.todos,
              onTodoEdit: (todo) {
                _showTodoDialog(context, todo);
              },
              onTodoDelete: (todo) {
                BlocProvider.of<TodosBloc>(context).add(DeleteTodoEvent(todo));
              },
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class TodoContent extends StatefulWidget {
  final List<TodoEntity>? todos;
  final void Function(TodoEntity todo)? onTodoEdit;
  final void Function(TodoEntity todo)? onTodoDelete;

  const TodoContent({
    Key? key,
    this.todos,
    this.onTodoEdit,
    this.onTodoDelete,
  }) : super(key: key);

  @override
  _TodoContentState createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildAddTodoFab(context),
    );
  }

  Widget _buildBody() {
    switch (widget.todos!.isNotEmpty) {
      case true:
        return AvailableTodoContent(
          todos: widget.todos!,
          onTodoEdit: widget.onTodoEdit,
          onTodoDelete: widget.onTodoDelete,
        );

      case false:
        return const Center(
          child: Text(
            'Empty Todo, Try to Create One',
            style: AppTypography.noteDate,
          ),
        );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 86.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
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

  Widget _buildAddTodoFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showTodoDialog(context, null),
      child: const Icon(Ionicons.add),
    );
  }
}

Future<void> _showTodoDialog(BuildContext context, TodoEntity? todo) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return TodoDialog(todo: todo);
    },
  );
  BlocProvider.of<TodosBloc>(context).add(const GetAllTodoEvent());
}
