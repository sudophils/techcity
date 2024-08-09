import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'notedata.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  String tableNotes = '''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        noteTitle TEXT,
        noteBody TEXT,
        noteDate TEXT,
        mustRead INTEGER,
        folderId INTEGER,
        FOREIGN KEY (folderId) REFERENCES folders(id)
      )
    ''';

  String tableFolders = '''
      CREATE TABLE folders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''';

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(tableFolders);
    await db.execute(tableNotes);
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertFolder(String folderName) async {
    final db = await database;
    await db.insert(
      'folders',
      {'name': folderName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int?> getFolderIdForNote(int noteId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'notes',
      columns: ['folderId'],
      where: 'id = ?',
      whereArgs: [noteId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['folderId'] as int?;
    }
    return null;
  }


  Future<List<Note>> notes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<Map<String, List<Note>>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT notes.*, folders.name as folder
      FROM notes
      LEFT JOIN folders ON notes.folderId = folders.id
    ''');

    Map<String, List<Note>> notesInFolder = {};

    for (var map in maps) {
      Note note = Note.fromMap(map);
      String folder = map['folder'] ?? 'Disorganised';
      if (!notesInFolder.containsKey(folder)) {
        notesInFolder[folder] = []; // creates empty folder
      }
      notesInFolder[folder]!.add(note); // adds note to folder
    }
    return notesInFolder; // return folder
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}