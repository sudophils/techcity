import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:techcity/screen/signup_screen.dart';

import '../viewmodel/note_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login into NoteApp',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              controller: emailController,
            ),
            TextField(
              obscureText: true, // Show password as dots
              controller: passwordController,
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                authController.loginUser(context,
                    email: emailController.text,
                    password: passwordController.text);
              },
              child: Container(
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () => Get.to(const SignupScreen()),
                child: const Text("New User")),
          ],
        ),
      ),
    );
  }
}
