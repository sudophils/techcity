import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techcity/database-lesson/firebase.dart';

import '../../viewmodel/note_viewmodel.dart';
import '../data/notedata.dart';

class NoteEditingScreen extends StatefulWidget {
  const NoteEditingScreen({
    super.key,
  });

  @override
  State<NoteEditingScreen> createState() => _NoteEditingScreenState();
}

class _NoteEditingScreenState extends State<NoteEditingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final FirebaseService _firebaseService = FirebaseService();

  String? _imageUrl;

  Future<void> _uploadImage() async {
    _imageUrl = "";
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String? downloadUrl = await _firebaseService.uploadImage(pickedFile.path);
      if (downloadUrl == null) {
        throw Exception('Error uploading image');
      }
      setState(() {
        _imageUrl = downloadUrl;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _imageUrl = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NoteController());
    final authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _uploadImage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Note Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Note Body'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty &&
                    _bodyController.text.isNotEmpty) {
                  Note note = Note(
                    userId: authController.user?.uid ?? '',
                    noteTitle: _titleController.text,
                    noteBody: _bodyController.text,
                    noteDate: DateTime.now().toIso8601String(),
                    imageUrl: _imageUrl ?? '',
                    folderId: Get.arguments['folderId'],
                  );
                  controller.saveNote(note);
                  controller.fetchNotesInFolder(
                      folder: Get.arguments['folderId']);
                  Get.back();
                }
              },
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
