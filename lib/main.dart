import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techcity/screen/login_screen.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NoteViewModel.initDb();
  runApp(const MyApp());
}

void logOutOnSessionExpire() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null || FirebaseAuth.instance.currentUser == null) {

      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logOutOnSessionExpire();
    });
  }

  @override
  Widget build(BuildContext context) {

    Get.put(AuthController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TechCity",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
