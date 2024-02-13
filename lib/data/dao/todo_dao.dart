import 'package:flutter_floor/model/todo.dart';
import 'package:floor/floor.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todo ORDER BY important DESC, task')
  Future<List<Todo>> getAllTodoOrderByImportantAndTask();

  @Query('DELETE FROM todo')
  Future<void> deleteAllTodo();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> createTodo(Todo todos);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTodo(Todo todos);

  @delete
  Future<void> deleteTodo(Todo todos);
}
