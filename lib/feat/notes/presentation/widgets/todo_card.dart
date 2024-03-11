import 'package:flutter/material.dart';
import 'package:flutter_floor/config/themes/typography.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:ionicons/ionicons.dart';

class AvailableTodoContent extends StatelessWidget {
  final List<TodoEntity>? todos;
  final void Function(TodoEntity todo)? onTodoEdit;
  final void Function(TodoEntity todo)? onTodoDelete;

  const AvailableTodoContent({
    Key? key,
    required this.todos,
    required this.onTodoEdit,
    required this.onTodoDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: todos!.length,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final todo = todos![index];
        return TodoCard(
          todo: todo,
          onTodoEdit: onTodoEdit,
          onTodoDelete: onTodoDelete,
        );
      },
    );
  }
}

class TodoCard extends StatelessWidget {
  final TodoEntity? todo;
  final void Function(TodoEntity todo)? onTodoEdit;
  final void Function(TodoEntity todo)? onTodoDelete;

  const TodoCard({
    Key? key,
    this.todo,
    this.onTodoEdit,
    this.onTodoDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                onTodoDelete!(todo!);
              },
              icon: const Icon(Ionicons.checkmark_circle),
            ),
            Expanded(
              flex: 1,
              child: Text(
                todo?.task ?? '',
                style: AppTypography.noteTitle,
              ),
            ),
            if (todo!.isImportant == true)
              IconButton(
                onPressed: null,
                icon: Icon(
                  Ionicons.alert_circle,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            IconButton(
              onPressed: () {
                onTodoEdit!(todo!);
              },
              icon: const Icon(Ionicons.create_outline),
            )
          ],
        ),
      ),
    );
  }
}
