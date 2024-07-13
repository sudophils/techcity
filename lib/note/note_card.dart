import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String noteTitle;
  final String noteBody;
  final String date;
  final bool mustRead;

  const NoteCard(
      {super.key,
      required this.noteTitle,
      required this.noteBody,
      required this.date,
      required this.mustRead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(noteTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  Text(noteBody,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (mustRead)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Must Read',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                    ),
                  ),
                SizedBox(
                  width: 8,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(date,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
