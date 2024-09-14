import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String noteTitle;
  final String noteBody;
  final String date;
  final bool mustRead;
  final String? noteImageUrl;

  const NoteCard(
      {super.key,
      required this.noteTitle,
      required this.noteBody,
      required this.date,
      this.noteImageUrl,
      required this.mustRead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Container(
            height: 250,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                // note image
                SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(noteImageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, error) => Container(
                            padding: const EdgeInsetsDirectional.all(12),
                            child: const Placeholder(),
                          )),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          noteTitle.length < 15
                              ? noteTitle
                              : noteTitle.substring(0, 10),
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
                    const SizedBox(
                      width: 8,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(date.split("T").first,
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
        ],
      ),
    );
  }
}
