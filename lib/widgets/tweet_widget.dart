import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweetWidget extends StatefulWidget {
  final String tweetText;
  final String userName;
  final String handle;
  final String? tweetPhoto;
  final String time;
  final String userAvatar;
  final String likeCount;
  final double retweetCount;
  final double impressionCount;
  final double commentCount;

  const TweetWidget(
      {required this.userName,
      required this.tweetText,
      required this.handle,
      this.tweetPhoto,
      required this.time,
      required this.userAvatar,
      required this.likeCount,
      required this.retweetCount,
      required this.impressionCount,
      required this.commentCount,
      super.key});

  @override
  State<TweetWidget> createState() => _TweetWidgetState();
}

class _TweetWidgetState extends State<TweetWidget> {
  double commentCount = 0;
  double likeCount = 0;
  double analyticsCount = 0;
  double retweetCount = 0;
  double shareCount = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                  child: Image.network(
                widget.userAvatar,
                width: 40,
              )),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.userName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(widget.handle),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(widget.time)
                    ],
                  ),
                  Text(widget.tweetText),
                  const SizedBox(
                    height: 8,
                  ),
                  if (widget.tweetPhoto != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.tweetPhoto!,
                        width: size.width * 0.7,
                        errorBuilder: (context, error, _) {
                          return Container();
                        },
                      ),
                    ),
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.67,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildActionButton(
                            label: commentCount.toString(),
                            icon: Icons.comment,
                            action: () {
                              setState(() {
                                commentCount++;
                              });
                            }),
                        buildActionButton(
                            label: retweetCount.toString(),
                            icon: FontAwesomeIcons.retweet,
                            action: () {
                              if (retweetCount == 1) return;
                              setState(() {
                                retweetCount++;
                              });

                            }),
                        buildActionButton(
                            label: likeCount.toString(),
                            icon: Icons.favorite,
                            action: () {}),
                        buildActionButton(
                            label: analyticsCount.toString(),
                            icon: Icons.analytics,
                            action: () {}),
                        buildActionButton(
                            label: shareCount.toString(),
                            icon: Icons.ios_share,
                            action: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider(
            thickness: .5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget buildActionButton(
      {required String label,
      required IconData icon,
      required Function() action}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: action,
            child: Icon(
              icon,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 4),
            child: Text(label,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
