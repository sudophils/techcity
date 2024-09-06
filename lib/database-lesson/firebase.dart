import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'data/notedata.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Authentication
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw "Invalid email address";
      } else if (e.code == 'wrong-password') {
        throw "Invalid password provided";
      } else {
        throw "An error occurred: $e.message";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw "Email address already in use";
      } else if (e.code == 'invalid-email') {
        throw "Invalid email address";
      } else {
        throw "An error occurred: $e.message";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // CRUD Operations for Notes
  Future<void> addNote(Note note, {String? imageUrl}) async {
    Map<String, dynamic> data = note.toMap();
    if (imageUrl != null) {
      data['imageUrl'] = imageUrl;
    }
    await _firestore.collection('notes').add(data);
  }

  Future<List<Note>> getNotesByFolderId(String folderId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('notes')
        .where('folderId', isEqualTo: folderId)
        .get();
    return snapshot.docs
        .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<List<Folder>> getFolders() async {
    QuerySnapshot snapshot = await _firestore.collection('folder').get();

    final folders = snapshot.docs
        .map(
            (doc) => Folder.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return folders;
  }

  // Future<List<Note>> getNotes() async {
  //   QuerySnapshot snapshot = await _firestore.collection('notes').get();
  //   return snapshot.docs
  //       .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  Future<void> updateNote(String noteId, Note note) async {
    await _firestore.collection('notes').doc(noteId).update(note.toMap());
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }

  // Upload Image to Firebase Storage
  Future<String?> uploadImage(String filePath) async {
    File file = File(filePath);
    try {
      TaskSnapshot snapshot = await _storage
          .ref('images/${file.uri.pathSegments.last}')
          .putFile(file);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addFolder(String name) async {
    await _firestore.collection('folder').add({'name': name});
  }
}
