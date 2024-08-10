import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:techcity/database-lesson/data/form_providerr.dart';
import 'package:techcity/widgets/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class AppFormData {
  final int? id;
  final String name;
  final String dob;
  final String course;
  final String time;
  final String day;
  final String essay;

  AppFormData(
      {this.id,
      required this.name,
      required this.dob,
      required this.course,
      required this.time,
      required this.day,
      required this.essay});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_name': name,
      'user_dob': dob,
      'user_course': course,
      'reg_time': time,
      'reg_day': day,
      'user_essay': day,
    };
  }

  factory AppFormData.fromMap(Map<String, dynamic> map) {
    return AppFormData(
        id: map['id'],
        name: map['user_name'],
        dob: map['user_dob'],
        course: map['user_course'],
        time: map['reg_time'],
        day: map['reg_day'],
        essay: map['user_essay']);
  }
}

class _HomeState extends State<Home> {
  final provider = FormProvider();

  String dob = "";
  String time = "";
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController essayController = TextEditingController();

  Future<void> openAppDatabase() async {
    await provider.open(await getDatabasesPath());
  }

  void register() async {
    final formPayload = AppFormData(
        id: 0,
        name: nameEditingController.text,
        dob: dobController.text,
        course: courseController.text,
        time: timeController.text,
        day: dayController.text,
        essay: essayController.text);
    final saved = await provider.insert(formPayload);
    if (saved != 0) {
      print('registered successfully');
    }
  }

  @override
  void initState() {
    openAppDatabase();
    super.initState();
  }

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
            child: GestureDetector(
              onTap: () {
                register();
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
            ),
          )
        ],
      ),
    ));
  }

// name
}
