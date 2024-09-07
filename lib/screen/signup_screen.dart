import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup for NoteApp',
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
                  authController.registerUser(context,
                      email: emailController.text,
                      password: passwordController.text);
                },
                child: Container(
                  height: 55,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text('Register'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
