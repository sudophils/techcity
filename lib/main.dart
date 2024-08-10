import 'package:flutter/material.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

import 'api-networking-lesson/post_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteViewModel.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TechCity",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const TechCityBlog(),
    );
  }
}
