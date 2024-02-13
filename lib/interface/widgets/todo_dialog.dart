import 'package:flutter/material.dart';
import 'package:flutter_floor/constants/typography.dart';
import 'package:flutter_floor/model/todo.dart';
import 'package:flutter_floor/provider/todo_provider.dart';

class TodoDialog extends StatefulWidget {
  final Todo? todo;
  final TodoProvider todoProvider;

  TodoDialog({Key? key, required this.todo, required this.todoProvider})
      : super(key: key);

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late TextEditingController taskController;
  late bool isChecked;

  Future<void> createTodo() async {
    Todo todos = Todo(
      null,
      taskController.text.toString(),
      isChecked,
    );
    setState(() {
      widget.todoProvider.todos.add(todos);
    });
    await widget.todoProvider.insertTodo(todos);
  }

  Future<void> updateTodo() async {
    widget.todo!.isImportant = isChecked;
    widget.todo!.todoTask = taskController.text;
    await widget.todoProvider.updateTodo(widget.todo!);
  }

  @override
  void initState() {
    super.initState();
    isChecked = widget.todo?.isImportant ?? false;
    taskController = TextEditingController(text: widget.todo?.todoTask ?? '');
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
    Future.delayed(const Duration(milliseconds: 300), () async {
      return await widget.todoProvider.getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (widget.todo != null) {
                      updateTodo();
                    } else {
                      createTodo();
                    }
                    Navigator.pop(context);
                    return await widget.todoProvider.getAllTodos();
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
