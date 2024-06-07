import 'package:flutter/material.dart';
import 'package:techcity/widgets/header.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: appBody());
  }

  // name
  // course
  // days
  // time
  // state of origin
  // short essay
  // dob

  Widget appBody() {
    return ListView(
      children: [
        SizedBox(
          height: 50,
        ),
        HeaderWidget(),
        Text("Registeration ")
      ],
    );
  }
}
