import 'dart:convert';
import 'dart:developer';
import 'package:expense_manager_frontend/view/widget/custom_inputfield.dart';
import 'package:http/http.dart' as http;
import 'package:expense_manager_frontend/controller/user_controller.dart';
import 'package:expense_manager_frontend/view/screens/home_screen.dart';
import 'package:expense_manager_frontend/view/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            SvgPicture.asset(
              'assets/Svg/logo.svg',
              width: 100,
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Login to your Account",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
             // Form Fields
               CustomInputfield().buildInputField(
                  controller: _emailController,
                  hintText: "Email",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
              
               CustomInputfield().buildInputField(
                  controller: _passwordController,
                  hintText: "Password",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  final res = await UserController().loginUser(
                      _emailController.text.trim(),
                      _passwordController.text.trim());

                  final resBody = jsonDecode(res.body);

                  if (res.statusCode == 200 || res.statusCode == 201) {
                    // Navigate to home screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  } else {
                    // // Simulate delay
                    // await Future.delayed(const Duration(seconds: 1));
                    // Failure SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Login failed! ${resBody["message"] ?? "Invalid credentials"}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter email and password"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(14, 161, 125, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  " Sign in",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegisterScreen();
                    },
                  ),
                );
              },
              child: const Text.rich(
                TextSpan(
                  text: "Don’t have an account? ",
                  style: TextStyle(fontSize: 18),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        color: Color.fromRGBO(14, 161, 125, 1),
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
