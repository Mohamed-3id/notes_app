import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Note {
  int id;
  String title;
  String content;
  Note(this.id, this.title, this.content);
}

class DatabaseHandler {
  static Database _db;
  static const String DATABASE_NAME = 'mydatabase.db';
  static const int DATABASE_VERSION = 1;

  static const String TABLE_NAME = 'notes';

  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME_1 = 'title';
  static const String COLUMN_NAME_2 = 'content';

  Future<Database> get db async {
    String path = join(await getDatabasesPath(), DATABASE_NAME);

    if (_db == null) {
      // Open Connection

      _db = await openDatabase(
        path,
        version: DATABASE_VERSION,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    }
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'create table $TABLE_NAME ($COLUMN_ID integer primary key, $COLUMN_NAME_1 text, $COLUMN_NAME_2 text)',
    );
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('drop table $TABLE_NAME');
    await _onCreate(db, newVersion);
  }

//############################################################

  // Insert
  Future<Note> insert(Note note) async {
    Database myNotes = await db;
    int id = await myNotes.insert(
      TABLE_NAME,
      {
        'id': note.id,
        'title': note.title,
        'content': note.content,
      },
    );
    note.id = id;
    return note;
  }


//############################################################

// Select All Posts
  Future<List<Note>> getPosts() async {
    Database myNotes = await db;

    List<Map> maps = await myNotes.query(
      TABLE_NAME,
      columns: [COLUMN_ID, COLUMN_NAME_1, COLUMN_NAME_2],
    );

    List<Note> notes = [];

    if (maps.length > 0) {
      for (var i = 0; i < maps.length; i++) {
        Map map = maps[i];
        Note note = new Note(
          map['id'],
          map['title'],
          map['content'],
        );
        notes.add(note);
      }
    }
    return notes;
  }

//############################################################

  // Delete

  delete(int id) async {
    Database dbNotes = await db;
    int numofNote = await dbNotes
        .delete(TABLE_NAME, where: '$COLUMN_ID= ?', whereArgs: [id]);
    return numofNote;
  }

//############################################################

  // Update
  Future<int> update(Note note) async {
    Database dbNotes = await db;
    int numofNote = await dbNotes.update(
        TABLE_NAME, {'title': note.title, 'content': note.content},
        where: '$COLUMN_ID = ?', whereArgs: [note.id]);
    return numofNote;
  }
}
