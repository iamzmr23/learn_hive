// ignore_for_file: use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn_hive/main.dart';
import 'package:learn_hive/src/models/user.dart';
import 'package:learn_hive/src/pages/home_page.dart';
import 'package:learn_hive/src/pages/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              onPressed: buttonLogin,
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
                    recognizer: TapGestureRecognizer()..onTap = gotoRegistration,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonLogin() async {
    List<Map<String, Object?>> response = auth.getData;
    List<User> users = response.map((e) => User.fromJson(e)).toList();
    List<User> haveUser = users.where((user) {
      return user.email == emailController.text.trim() && user.password == passwordController.text.trim();
    }).toList();

    if (haveUser.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Not Found")));
    } else {
      await auth.saveUser(haveUser[0]);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    }
  }

  void gotoRegistration() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationPage(),
      ),
    );
  }
}
