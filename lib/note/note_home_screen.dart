import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

import '../data/notedata.dart';
import 'note_type_screen.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildFolderItem(
        {required String sNumber,
        required String heading,
        required String noteCount,
        required Function() action}) {
      return GestureDetector(
        onTap: action,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(sNumber,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    heading,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontWeight: FontWeight.w900),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text('$noteCount Notes',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500)),
              Divider(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Text('MENU'),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: ScopedModel<NoteViewModel>(
        model: NoteViewModel(),
        child: ScopedModelDescendant<NoteViewModel>(
            builder: (context, child, model) {
          if (model.allNotes.isEmpty) {
            model.fetchAllNotes();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All folders',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const Row(
                          children: [
                            Text('This month'),
                            Icon(Icons.calendar_month)
                          ],
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        model.saveNote(Note(
                          noteTitle: "Sample Note",
                          noteBody: "This is a sample note body.",
                          noteDate: "2024-07-19",
                          category: 'Monday Vibes',
                        ));
                        model.fetchAllNotes();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black38)),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    ...model.allNotes.entries.map((noteType) {
                      final idx =
                          model.allNotes.keys.toList().indexOf(noteType.key) +
                              1;
                      final count = noteType.value.length;
                      return buildFolderItem(
                          action: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteTypesScreen(
                                          type: noteType.key,
                                          notes: noteType.value,
                                        )));
                          },
                          sNumber: idx.toString(),
                          heading: noteType.key,
                          noteCount: count.toString());
                    }).toList()
                  ],
                ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
