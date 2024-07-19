class Note {
  final int? id;
  final String noteTitle;
  final String noteBody;
  final String noteDate;
  final bool mustRead;
  final String category;

  Note({
    this.id,
    required this.noteTitle,
    required this.noteBody,
    required this.noteDate,
    this.mustRead = false,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noteTitle': noteTitle,
      'noteBody': noteBody,
      'noteDate': noteDate,
      'mustRead': mustRead ? 1 : 0,
      'category': category,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      noteTitle: map['noteTitle'],
      noteBody: map['noteBody'],
      noteDate: map['noteDate'],
      mustRead: map['mustRead'] == 1,
      category: map['category'],
    );
  }
}