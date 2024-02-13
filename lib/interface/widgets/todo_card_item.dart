import 'package:flutter/material.dart';
import 'package:flutter_floor/constants/typography.dart';
import 'package:flutter_floor/model/todo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodoCardItem extends StatefulWidget {
  final Todo? todo;
  final VoidCallback onTodoDelete;
  final VoidCallback onTodoUpdate;

  const TodoCardItem(
      {Key? key,
      required this.todo,
      required this.onTodoDelete,
      required this.onTodoUpdate})
      : super(key: key);

  @override
  _TodoCardItemState createState() => _TodoCardItemState();
}

class _TodoCardItemState extends State<TodoCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton(
              onPressed: widget.onTodoDelete,
              icon: const Icon(
                Icons.check,
                color: Colors.blueAccent,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                widget.todo!.todoTask,
                style: AppTypography.noteTitle,
              ),
            ),
            if (widget.todo!.isImportant == true)
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/star.svg',
                  color: Colors.blueAccent,
                ),
              ),
            IconButton(
              onPressed: widget.onTodoUpdate,
              icon: const Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
