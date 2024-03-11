// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `notes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `content` TEXT, `createdDate` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `task` TEXT, `isImportant` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteEntityInsertionAdapter = InsertionAdapter(
            database,
            'notes',
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdDate': item.createdDate
                }),
        _noteEntityUpdateAdapter = UpdateAdapter(
            database,
            'notes',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdDate': item.createdDate
                }),
        _noteEntityDeletionAdapter = DeletionAdapter(
            database,
            'notes',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdDate': item.createdDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteEntity> _noteEntityInsertionAdapter;

  final UpdateAdapter<NoteEntity> _noteEntityUpdateAdapter;

  final DeletionAdapter<NoteEntity> _noteEntityDeletionAdapter;

  @override
  Future<List<NoteEntity>> searchNotes(String search) async {
    return _queryAdapter.queryList(
        'SELECT * FROM notes WHERE title LIKE \'%\' || ?1 || \'%\' OR content LIKE \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => NoteEntity(id: row['id'] as int?, title: row['title'] as String?, content: row['content'] as String?, createdDate: row['createdDate'] as String?),
        arguments: [search]);
  }

  @override
  Future<List<NoteEntity>> getAllNotesOrderByDate() async {
    return _queryAdapter.queryList(
        'SELECT * FROM notes ORDER BY createdDate DESC',
        mapper: (Map<String, Object?> row) => NoteEntity(
            id: row['id'] as int?,
            title: row['title'] as String?,
            content: row['content'] as String?,
            createdDate: row['createdDate'] as String?));
  }

  @override
  Future<void> deleteAllNotes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM notes');
  }

  @override
  Future<void> insertNote(NoteEntity note) async {
    await _noteEntityInsertionAdapter.insert(note, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    await _noteEntityUpdateAdapter.update(note, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    await _noteEntityDeletionAdapter.delete(note);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoEntityInsertionAdapter = InsertionAdapter(
            database,
            'todos',
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'isImportant': item.isImportant == null
                      ? null
                      : (item.isImportant! ? 1 : 0)
                }),
        _todoEntityUpdateAdapter = UpdateAdapter(
            database,
            'todos',
            ['id'],
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'isImportant': item.isImportant == null
                      ? null
                      : (item.isImportant! ? 1 : 0)
                }),
        _todoEntityDeletionAdapter = DeletionAdapter(
            database,
            'todos',
            ['id'],
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'task': item.task,
                  'isImportant': item.isImportant == null
                      ? null
                      : (item.isImportant! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoEntity> _todoEntityInsertionAdapter;

  final UpdateAdapter<TodoEntity> _todoEntityUpdateAdapter;

  final DeletionAdapter<TodoEntity> _todoEntityDeletionAdapter;

  @override
  Future<List<TodoEntity>> getTodosOrderByImportantAndTask() async {
    return _queryAdapter.queryList(
        'SELECT * FROM todos ORDER BY isImportant DESC, task',
        mapper: (Map<String, Object?> row) => TodoEntity(
            id: row['id'] as int?,
            task: row['task'] as String?,
            isImportant: row['isImportant'] == null
                ? null
                : (row['isImportant'] as int) != 0));
  }

  @override
  Future<void> deleteAllTodos() async {
    await _queryAdapter.queryNoReturn('DELETE FROM todos');
  }

  @override
  Future<void> insertTodo(TodoEntity todos) async {
    await _todoEntityInsertionAdapter.insert(todos, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    await _todoEntityUpdateAdapter.update(todo, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTodo(TodoEntity todos) async {
    await _todoEntityDeletionAdapter.delete(todos);
  }
}
