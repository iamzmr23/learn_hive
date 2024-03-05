// ignore_for_file: avoid_print
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn_hive/main.dart';
import 'package:learn_hive/src/models/user.dart';
import 'package:learn_hive/src/pages/login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Registration Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Enter Name"),
            ),
            const SizedBox(height: 20),
            // Email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Enter Email"),
            ),

            const SizedBox(height: 20),

            // Password
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "Enter Password"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: buttonRegistration,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: const Text("Registration"),
            ),

            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Login",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = gotoLogin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonRegistration() {
    User user = User(
      id: Random().nextInt(1000),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    auth.storeData(user);
    gotoLogin();

    print(auth.getData);
  }

  void gotoLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
