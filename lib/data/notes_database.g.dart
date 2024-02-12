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

  NotesDao? _daoInstance;

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

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NotesDao get dao {
    return _daoInstance ??= _$NotesDao(database, changeListener);
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
  Future<void> createNote(Notes notes) async {
    await _notesInsertionAdapter.insert(notes, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateNote(Notes notes) async {
    await _notesUpdateAdapter.update(notes, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNote(Notes notes) async {
    await _notesDeletionAdapter.delete(notes);
  }
}
