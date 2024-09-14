import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techcity/database-lesson/note/note_editing_screen.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

import 'note_card.dart';

class NoteTypesScreen extends GetView<NoteController> {
  final String folderId;

  const NoteTypesScreen({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NoteController());
    controller.fetchNotesInFolder(folder: folderId);

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Obx(
            () => Padding(
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
                            'type',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          Text(
                              '${controller.allNotesFirebase.length.toString()} Notes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const NoteEditingScreen(),
                              arguments: {"folderId": folderId});
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
                  controller.allNotesFirebase.isEmpty == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            crossAxisCount: 2,
                            children: [
                              ...controller.allNotesFirebase.map((note) =>
                                  NoteCard(
                                      noteTitle: note.noteTitle,
                                      noteBody: note.noteBody,
                                      date: note.noteDate,
                                      noteImageUrl: note.imageUrl,
                                      mustRead: note.mustRead))
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
