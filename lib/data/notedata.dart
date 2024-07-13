class Note {
  final String noteTitle;
  final String noteBody;
  final String noteDate;
  final bool mustRead;

  Note(
      {required this.noteTitle,
      required this.noteBody,
      required this.noteDate,
      this.mustRead = false});
}



Map<String, List<Note>> allNotes = {
  "Personal Notes": personalNotesList,
  "Educational": educationalNote,
  "Daily Todo": dailyTodoNotes,
  "Grocery ": groceryNotes,
  "Monday Work ": mondayWorkNotes,
};
final List<Note> personalNotesList = [
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      mustRead: true,
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05')
];

final List<Note> educationalNote = [

  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05')
];
final List<Note> dailyTodoNotes = [
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      mustRead: true,
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05')
];
final List<Note> groceryNotes = [
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      mustRead: true,
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05')
];
final List<Note> mondayWorkNotes = [
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05'),
  Note(
      noteTitle: "Today's Quote",
      mustRead: true,
      noteBody: 'Keep your face in the sunshine and you cannot see shadows',
      noteDate: 'Sat. 08:05')
];
