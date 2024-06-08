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
                    firstDate: DateTime(2017),
                    lastDate: DateTime.now()),
                decoration: const InputDecoration(hintText: "DOB"),
              )),
            ],
          ),
          const TextField(
            decoration: InputDecoration(hintText: "Enter Course"),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                onTap: () async => await showTimePicker(
                    context: context, initialTime: TimeOfDay.now()),
                decoration: const InputDecoration(hintText: "Time"),
              )),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                flex: 4,
                child: TextField(
                  decoration: InputDecoration(hintText: "Day"),
                ),
              ),
            ],
          ),
          const TextField(
            decoration: InputDecoration(hintText: "State of origin"),
          ),
          const SizedBox(
            height: 24,
          ),
          const TextField(
            maxLines: 4,
            maxLength: 2000,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "Short essay",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                shape: BoxShape.rectangle,
                color: Colors.red),
            child: const Center(
              child: Text(
                "Submit detail",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
