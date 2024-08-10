import 'package:flutter/material.dart';
import 'package:techcity/blog/post.dart';



class PostCard extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final Reactions reactions;
  final int views;

  const PostCard(
      {super.key,
      required this.id,
      required this.title,
      required this.body,
      required this.tags,
      required this.reactions,
      required this.views});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(body,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400)),
            ),
            Row(
              children: [...tags.map((tag) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(label: Text(tag)),
              ))],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(views.toString()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.thumb_up),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(reactions.likes.toString()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.thumb_down),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(reactions.dislikes.toString()),
                      ),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
