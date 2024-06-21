import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterHome extends StatefulWidget {
  const TwitterHome({super.key});

  @override
  State<TwitterHome> createState() => _TwitterHomeState();
}

class _TwitterHomeState extends State<TwitterHome> {
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
        return const TwitterThreadPage();
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
        return const TwitterThreadPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
            child: Icon(FontAwesomeIcons.twitter, color: Colors.blueAccent),
          )
        ],
        // centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              ClipOval(child: Image.asset('assets/images/tech_city_logo.png')),
        ),
      ),
      body: buildHomeBody(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
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
  const TwitterThreadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
