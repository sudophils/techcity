import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

import 'note_type_screen.dart';

class NoteHomeScreen extends GetView<FolderController> {
  NoteHomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(FolderController());

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
      body: Padding(
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
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Create a new folder",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge),
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                      labelText: 'Folder Name'),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.black),
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (_controller.text.isNotEmpty) {
                                              controller.createNoteFolder(
                                                  _controller.text);

                                              _controller.text = '';
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Center(
                                            child: Text(
                                              'Add Folder',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                    // model.createNoteFolder("Coding notes");
                    // model.fetchAllNotes();
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
                child: controller.obx(
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: Text("Nothing found"),
              onError: (error) {
                print("Error: ${error}");
                return Text("Nothing found");
              },
              (folders) => ListView(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  ...?folders?.map((folder) {
                    final idx = folders.indexOf(folder) + 1;
                    return buildFolderItem(
                        sNumber: idx.toString(),
                        heading: folder.name,
                        noteCount: '',
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteTypesScreen(
                                        folderId: folder.id as String,
                                      )));
                        });
                  }).toList(),

                  ///IGNORE  with local database
                  // ...model.allNotes.entries.map((noteType) {
                  //   final idx =
                  //       model.allNotes.keys.toList().indexOf(
                  //           noteType.key) +
                  //           1;
                  //   final count = noteType.value.length;
                  //   return buildFolderItem(
                  //       action: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     NoteTypesScreen(
                  //                       type: noteType.key,
                  //                       notes: noteType.value,
                  //                     )));
                  //       },
                  //       sNumber: idx.toString(),
                  //       heading: noteType.key,
                  //       noteCount: count.toString());
                  // }).toList()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
