import 'package:flutter/material.dart';
import 'package:flutter_floor/constants/colors.dart';
import 'package:flutter_floor/constants/typography.dart';
import 'package:flutter_floor/interface/widgets/todo_card_item.dart';
import 'package:flutter_floor/interface/widgets/todo_dialog.dart';
import 'package:flutter_floor/model/todo.dart';
import 'package:flutter_floor/provider/todo_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TodoProvider _todoProvider;

  @override
  void initState() {
    super.initState();
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    _todoProvider.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    _todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _todoProvider.deleteAllTodos();
          },
          icon: SvgPicture.asset(
            'assets/trash-2.svg',
            color: deleteIconColor,
          ),
        ),
      ),
      body: Consumer<TodoProvider>(builder: (context, todoProvider, _) {
        return todoProvider.todos.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/wind.svg',
                      width: 86.0,
                      height: 86.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Empty Todo',
                      style: AppTypography.dialogTitle,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: todoProvider.todos.length,
                itemBuilder: (context, index) {
                  Todo todo = todoProvider.todos[index];
                  return TodoCardItem(
                    todo: todo,
                    onTodoDelete: () {
                      deleteTodoAndRefreshList(todo);
                      setState(() {});
                    },
                    onTodoUpdate: () {
                      _dialogBuilder(context, todo);
                    },
                  );
                },
              );
      }
          // if (todoProvider.todos.isEmpty) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SvgPicture.asset(
          //           'assets/wind.svg',
          //           width: 86.0,
          //           height: 86.0,
          //           color: Colors.blue,
          //         ),
          //         const SizedBox(
          //           height: 16,
          //         ),
          //         const Text(
          //           'Empty Todo',
          //           style: AppTypography.dialogTitle,
          //         ),
          //       ],
          //     ),
          //   );
          // } else {
          //   return ListView.builder(
          //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //     itemCount: todoProvider.todos.length,
          //     itemBuilder: (context, index) {
          //       Todo todo = todoProvider.todos[index];
          //       return TodoCardItem(
          //         todo: todo,
          //         onTodoDelete: () {
          //           deleteTodoAndRefreshList(todo);
          //           setState(() {});
          //         },
          //         onTodoUpdate: () {
          //           _dialogBuilder(context, todo);
          //         },
          //       );
          //     },
          //   );
          // }
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context, null),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> deleteTodoAndRefreshList(Todo todos) async {
    await _todoProvider.deleteTodo(todos);
    return await _todoProvider.getAllTodos();
  }

  Future<void> _dialogBuilder(BuildContext context, Todo? todo) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return TodoDialog(
          todo: todo,
          todoProvider: _todoProvider,
        );
      },
    );
    return await _todoProvider.getAllTodos();
  }
}


/*
*/