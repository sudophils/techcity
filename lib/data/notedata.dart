class Folder {
  final int? id;
  final String name;

  Folder({ this.id, required this.name});
}

class Note {
  final int? id;
  final String noteTitle;
  final String noteBody;
  final String noteDate;
  final bool mustRead;
  final int folderId; // This references the folder's ID
  String? folder; // This will be used when fetching notes with folder names

  Note({
    this.id,
    required this.noteTitle,
    required this.noteBody,
    required this.noteDate,
    this.mustRead = false,
    required this.folderId,
    this.folder,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noteTitle': noteTitle,
      'noteBody': noteBody,
      'noteDate': noteDate,
      'mustRead': mustRead ? 1 : 0,
      'folderId': folderId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      noteTitle: map['noteTitle'],
      noteBody: map['noteBody'],
      noteDate: map['noteDate'],
      mustRead: map['mustRead'] == 1,
      folderId: map['folderId'],
      folder: map[
          'folder'], // This will be populated when joining with folders table
    );
  }
}
