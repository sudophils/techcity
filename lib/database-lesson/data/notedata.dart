class Folder {
  final String id;
  final String name;
  final int noteCount;

  Folder({required this.id, required this.name, this.noteCount = 0});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'noteCount': noteCount,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map, String id) {
    return Folder(
      id: id,
      name: map['name'],
      noteCount: map['noteCount'] ?? 0,
    );
  }
}

class Note {
  final dynamic id;
  final String noteTitle;
  final String noteBody;
  final String noteDate;
  final bool mustRead;
  final dynamic folderId;
  final String? imageUrl; // Nullable field for image URL
  String? folder;

  Note({
    this.id,
    required this.noteTitle,
    required this.noteBody,
    required this.noteDate,
    this.mustRead = false,
    required this.folderId,
    this.imageUrl,
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
      'imageUrl': imageUrl, // Include image URL in the map
    };
  }

  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(
      id: id,
      noteTitle: map['noteTitle'],
      noteBody: map['noteBody'],
      noteDate: map['noteDate'],
      mustRead: map['mustRead'] == 1,
      folderId: map['folderId'],
      imageUrl: map['imageUrl'], // Get image URL from map
      folder: map['folder'],
    );
  }
}