import 'package:flutter_floor/model/todo.dart';
import 'package:floor/floor.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todo ORDER BY task ASC')
  Future<List<Todo>> getAllTodoOrderByTask();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> createTodo(Todo todos);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTodo(Todo todos);

  @delete
  Future<void> deleteTodo(Todo todos);
}
