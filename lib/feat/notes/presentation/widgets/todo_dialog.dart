import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floor/config/themes/typography.dart';
import 'package:flutter_floor/feat/notes/data/entity/todo_entity.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_bloc.dart';
import 'package:flutter_floor/feat/notes/presentation/blocs/todos/todos_event.dart';
import 'package:ionicons/ionicons.dart';

class TodoDialog extends StatefulWidget {
  final TodoEntity? todo;

  const TodoDialog({Key? key, this.todo}) : super(key: key);

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late TextEditingController taskController;
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.todo?.isImportant ?? false;
    taskController = TextEditingController(text: widget.todo?.task ?? '');
  }

  @override
  void dispose() {
    taskController.dispose();
    BlocProvider.of<TodosBloc>(context).add(const GetAllTodoEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Ionicons.create,
              size: 24,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16.0),
            const Text('Todo', style: AppTypography.dialogTitle),
            const SizedBox(height: 16.0),
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Task',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Mark as Important',
                  style: AppTypography.noteDate,
                ),
                const SizedBox(width: 8.0),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.todo != null) {
                      final updatedTodo = TodoEntity(
                        id: widget.todo!.id,
                        task: taskController.text.toString(),
                        isImportant: isChecked,
                      );
                      BlocProvider.of<TodosBloc>(context)
                          .add(UpdateTodoEvent(updatedTodo));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Todo Updated'),
                        ),
                      );
                    } else {
                      final createTodo = TodoEntity(
                        task: taskController.text.toString(),
                        isImportant: isChecked,
                      );
                      BlocProvider.of<TodosBloc>(context).add(
                        SaveTodoEvent(createTodo),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Todo Saved'),
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
