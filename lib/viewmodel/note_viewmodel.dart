import 'package:scoped_model/scoped_model.dart';

import '../data/data_base.dart';
import '../data/notedata.dart';

class NoteViewModel extends Model {
  static late DatabaseService _db;
  Map<String, List<Note>> allNotes = {};

  static Future<void> initDb() async {
    _db = DatabaseService();
  }

  DatabaseService get db => _db;

  void saveNote(Note note) async {
    await _db.insertNote(note);
    notifyListeners();
  }

  void createNoteFolder(String name) async {
    await _db.insertFolder(name);
    notifyListeners();
  }

  Future<int?> getFolderId(int noteId) async {
    return await _db.getFolderIdForNote(noteId);
  }

  Future<void> fetchAllNotes() async {
    allNotes = await _db.getAllNotes();
    print(allNotes.length);
    notifyListeners();
  }

  void deleteNote(int id) async {
    await _db.deleteNote(id);
    notifyListeners();
  }

  updateNote(Note note) async {
    await _db.updateNote(note);
    notifyListeners();
  }

  int _cart = 0;

  int get cart => _cart;

  void updateCart() {
    _cart++;
    notifyListeners();
  }
}
