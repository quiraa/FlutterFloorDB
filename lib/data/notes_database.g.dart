// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorNotesDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NotesDatabaseBuilder databaseBuilder(String name) =>
      _$NotesDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NotesDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NotesDatabaseBuilder(null);
}

class _$NotesDatabaseBuilder {
  _$NotesDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$NotesDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NotesDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NotesDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NotesDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NotesDatabase extends NotesDatabase {
  _$NotesDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NotesDao? _noteDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `tbl_notes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `content` TEXT NOT NULL, `date` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `task` TEXT NOT NULL, `important` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NotesDao get noteDao {
    return _noteDaoInstance ??= _$NotesDao(database, changeListener);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$NotesDao extends NotesDao {
  _$NotesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _notesInsertionAdapter = InsertionAdapter(
            database,
            'tbl_notes',
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'title': item.noteTitle,
                  'content': item.noteContent,
                  'date': item.noteDate
                },
            changeListener),
        _notesUpdateAdapter = UpdateAdapter(
            database,
            'tbl_notes',
            ['id'],
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'title': item.noteTitle,
                  'content': item.noteContent,
                  'date': item.noteDate
                },
            changeListener),
        _notesDeletionAdapter = DeletionAdapter(
            database,
            'tbl_notes',
            ['id'],
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'title': item.noteTitle,
                  'content': item.noteContent,
                  'date': item.noteDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Notes> _notesInsertionAdapter;

  final UpdateAdapter<Notes> _notesUpdateAdapter;

  final DeletionAdapter<Notes> _notesDeletionAdapter;

  @override
  Future<List<Notes>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM tbl_notes',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['title'] as String,
            row['content'] as String,
            row['date'] as String));
  }

  @override
  Future<void> deleteAllNotes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM tbl_notes');
  }

  @override
  Stream<Notes?> getSingleNote(int noteId) {
    return _queryAdapter.queryStream('SELECT * FROM tbl_notes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['title'] as String,
            row['content'] as String,
            row['date'] as String),
        arguments: [noteId],
        queryableName: 'tbl_notes',
        isView: false);
  }

  @override
  Future<List<Notes>> getAllNotesOrderByDate() async {
    return _queryAdapter.queryList('SELECT * FROM tbl_notes ORDER BY date',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['title'] as String,
            row['content'] as String,
            row['date'] as String));
  }

  @override
  Future<List<Notes>> getAllNotesOrderByTitle() async {
    return _queryAdapter.queryList('SELECT * FROM tbl_notes ORDER BY title ASC',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['title'] as String,
            row['content'] as String,
            row['date'] as String));
  }

  @override
  Future<void> createNote(Notes notes) async {
    await _notesInsertionAdapter.insert(notes, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateNote(Notes notes) async {
    await _notesUpdateAdapter.update(notes, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNote(Notes note) async {
    await _notesDeletionAdapter.delete(note);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'todo',
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'task': item.todoTask,
                  'important': item.isImportant ? 1 : 0
                }),
        _todoUpdateAdapter = UpdateAdapter(
            database,
            'todo',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'task': item.todoTask,
                  'important': item.isImportant ? 1 : 0
                }),
        _todoDeletionAdapter = DeletionAdapter(
            database,
            'todo',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'task': item.todoTask,
                  'important': item.isImportant ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  final DeletionAdapter<Todo> _todoDeletionAdapter;

  @override
  Future<List<Todo>> getAllTodoOrderByImportantAndTask() async {
    return _queryAdapter.queryList(
        'SELECT * FROM todo ORDER BY important DESC, task',
        mapper: (Map<String, Object?> row) => Todo(row['id'] as int?,
            row['task'] as String, (row['important'] as int) != 0));
  }

  @override
  Future<void> deleteAllTodo() async {
    await _queryAdapter.queryNoReturn('DELETE FROM todo');
  }

  @override
  Future<void> createTodo(Todo todos) async {
    await _todoInsertionAdapter.insert(todos, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTodo(Todo todos) async {
    await _todoUpdateAdapter.update(todos, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTodo(Todo todos) async {
    await _todoDeletionAdapter.delete(todos);
  }
}
