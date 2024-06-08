import 'package:flutter/material.dart';
import 'package:techcity/widgets/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dob = "";
  String time = "";
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController essayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
              Expanded(
                  flex: 4,
                  child: TextField(
                    controller: nameEditingController,
                    decoration:
                        const InputDecoration(hintText: "Enter your name"),
                  )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: TextField(
                controller: dobController,
                onTap: () => showDatePicker(
                        context: context,
                        firstDate: DateTime(2017),
                        lastDate: DateTime.now())
                    .then((date) => setState(() =>
                        dobController.text = date.toString().split(" ").first)),
                decoration: const InputDecoration(hintText: "DOB"),
              )),
            ],
          ),
          TextField(
            controller: courseController,
            decoration: const InputDecoration(hintText: "Enter Course"),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: timeController,
                onTap: () async => await showTimePicker(
                        context: context, initialTime: TimeOfDay.now())
                    .then((selectedTime) => setState(() {
                          final time =
                              '${selectedTime!.hour.toString()}: ${selectedTime.minute.toString()}';

                          timeController.text = time;
                        })),
                decoration: const InputDecoration(hintText: "Time"),
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: dayController,
                  decoration: const InputDecoration(hintText: "Day"),
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
          TextField(
            controller: essayController,
            maxLines: 4,
            maxLength: 2000,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: "Short essay",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              final name = nameEditingController.text;
              setState(() {
                dob = dobController.text;
                time = timeController.text;
              });
              final course = courseController.text;
              final day = dayController.text;
              final essay = essayController.text;

              print(
                  "Name: $name \n,DOB: $dob \n,course: $course \n,time: $time, \nday: $day, \nessay: $essay");
            },
            child: Container(
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
            ),
          )
        ],
      ),
    ));
  }

// name
}
