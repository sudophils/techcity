import 'package:flutter/material.dart';
import 'package:techcity/note/note_card.dart';

import '../data/notedata.dart';

class NoteTypesScreen extends StatelessWidget {
  final String type;
  final List<Note> notes;

  const NoteTypesScreen({super.key, required this.type, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
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
                        type,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text('${notes.length.toString()} Notes',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black38)),
                    child: const Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                  children: [
                    ...notes.map((note) => NoteCard(
                        noteTitle: note.noteTitle,
                        noteBody: note.noteBody,
                        date: note.noteDate,
                        mustRead: note.mustRead))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
