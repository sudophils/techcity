import 'package:flutter/material.dart';
import 'package:techcity/screen/util.dart';
import 'package:techcity/widgets/tweet_widget.dart';

class TwitterHome extends StatefulWidget {
  const TwitterHome({super.key});

  @override
  State<TwitterHome> createState() => _TwitterHomeState();
}

class _TwitterHomeState extends State<TwitterHome>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTwitterTab = <Tab>[
    const Tab(text: 'For you'),
    const Tab(text: 'Following'),
  ];
  late TabController tabController;
  int currentIndex = 0;

  List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    const BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Space"),
    const BottomNavigationBarItem(icon: Icon(Icons.people), label: "Community"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notifications), label: "Notification"),
    const BottomNavigationBarItem(icon: Icon(Icons.email), label: "Message"),
  ];

  Widget buildHomeBody(int index) {
    switch (index) {
      case 0:
        return TwitterThreadPage(
          controller: tabController,
        );
      case 1:
        return Center(child: Text('Search'));
      case 2:
        return Center(child: Text('Space'));
      case 3:
        return Center(child: Text('Community'));
      case 4:
        return Center(child: Text('Notification'));
      case 5:
        return Center(child: Text('Message'));
      default:
        return TwitterThreadPage(
          controller: tabController,
        );
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
            child: Image.asset(
              'assets/images/tech_city_logo.png',
              width: 30,
            ),
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: myTwitterTab,
        ),
      ),
      body: buildHomeBody(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.red[200],
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          print(index);
          setState(() {
            currentIndex = index;
          });
        },
        items: navItems,
      ),
    );
  }
}

class TwitterThreadPage extends StatelessWidget {
  final TabController controller;

  const TwitterThreadPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ...tweetList.map((t) => TweetWidget(
                  tweetText: t.tweetText,
                  userName: t.userName,
                  handle: t.handle,
                  tweetPhoto: t.tweetPhoto,
                  time: t.time,
                  userAvatar: t.userAvatar,
                  likeCount: t.likeCount,
                  retweetCount: t.retweetCount,
                  impressionCount: t.impressionCount,
                  commentCount: t.commentCount))
            ],
          ),
        ),
        Text("Techcity"),
      ],
    );
  }
}

class Tweet {
  String tweetText;
  String userName;
  String handle;
  String tweetPhoto;
  String time;
  String userAvatar;
  String likeCount;
  double retweetCount;
  double impressionCount;
  double commentCount;

  Tweet(
      {required this.commentCount,
      required this.tweetText,
      required this.handle,
      required this.impressionCount,
      required this.likeCount,
      required this.retweetCount,
      required this.time,
      required this.tweetPhoto,
      required this.userAvatar,
      required this.userName});
}
