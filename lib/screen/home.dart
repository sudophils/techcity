
import 'package:flutter/material.dart';
import 'package:techcity/widgets/header.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: appBody(context));
  }

  // name
  // course
  // days
  // time
  // state of origin
  // short essay
  // dob

  Widget appBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          HeaderWidget(),
          const Text("Registration"),
          Row(
            children: [
              const Expanded(
                  flex: 4,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Enter your name"),
                  )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: TextField(
                onTap: () => showDatePicker(
                    context: context,
                    firstDate: DateTime(2017, 9, 7, 17, 30),
                    lastDate: DateTime.now()),
                decoration: const InputDecoration(hintText: "DOB"),
              )),
            ],
          ),
          const TextField(
            decoration: InputDecoration(hintText: "Enter Course"),
          )
        ],
      ),
    );
  }
}
