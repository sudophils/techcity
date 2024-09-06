import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:techcity/database-lesson/data/data_base.dart';
import 'package:techcity/database-lesson/data/notedata.dart';
import 'package:techcity/database-lesson/firebase.dart';
import 'package:techcity/database-lesson/note/note_home_screen.dart';
import 'package:techcity/screen/login_screen.dart';

class NoteViewModel extends Model {
  static late DatabaseService _db;
  Map<String, List<Note>> allNotes = {};

  static Future<void> initDb() async {
    _db = DatabaseService();
  }

  DatabaseService get db => _db;

  Future<int?> getFolderId(int noteId) async {
    return await _db.getFolderIdForNote(noteId);
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

class NoteController extends GetxController with StateMixin<Note> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Note> allNotesFirebase = [];
  bool loading = false;

  Future<void> fetchNotesInFolder({required String folder}) async {
    allNotesFirebase = await _firebaseService.getNotesByFolderId(folder);
  }

  void saveNote(Note note) async {
    _firebaseService.addNote(note);
  }
}

class FolderController extends GetxController with StateMixin<List<Folder>> {
  final FirebaseService _firebaseService = FirebaseService();
  final folders = [].obs;

  @override
  void onReady() {
    fetchFolders();
    super.onReady();
  }

  void createNoteFolder(String name) async {
    _firebaseService.addFolder(name);
    fetchFolders();
  }

  Future<void> fetchFolders() async {
    change([], status: RxStatus.loading());
    try {
      final found = await _firebaseService.getFolders();
      folders.value = found;
      change(found, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());

      print('Error fetching folders: $e');
    }
  }
}

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  User? _user;

  User? get user => _user;

  void gotToNoteScreenIfAuthenticated() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.to(NoteHomeScreen());
      }
    });
  }

  @override
  void onInit() {
    gotToNoteScreenIfAuthenticated();
    super.onInit();
  }

  void loginUser({required String email, required String password}) async {
    try {
      User? user = await _firebaseService.signInWithEmail(email, password);
      if (user != null) {
        final userId = user.uid;
        _user = user;
        Get.to(NoteHomeScreen());
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  void registerUser({required String email, required String password}) async {
    try {
      final user = await _firebaseService.signUpWithEmail(email, password);
      if (user != null) {
        _user = user;
        Get.to(LoginScreen());
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }
}
