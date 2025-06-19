import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:expense_manager_frontend/controller/user_controller.dart';
import 'package:expense_manager_frontend/view/screens/login_screen.dart';
import 'package:expense_manager_frontend/view/widget/custom_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _image;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

// picke img
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // App Title/Logo Area
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Create your account to get started",
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                // 👇 Profile Image Picker
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color.fromRGBO(14, 161, 125, 1),
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.add_a_photo,
                              size: 32, color: Colors.white)
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Form Fields
               CustomInputfield().buildInputField(
                  controller: _userNameController,
                  hintText: "Username",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),

                CustomInputfield().buildInputField(
                  controller: _emailController,
                  hintText: "Email",
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),

                CustomInputfield().buildInputField(
                  controller: _passwordController,
                  hintText: "Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 32),

                // Sign Up Button
                GestureDetector(
                  onTap: () async {
                    log("avatar is ${_image?.path}");

                    // Show loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>( Color.fromRGBO(14, 161, 125, 1),),
                        ),
                      ),
                    );

                    // Simulate a delay (optional)
                    await Future.delayed(const Duration(seconds: 2));

                    // Perform registration
                    var res = await UserController().registerUser(
                      _userNameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _image?.path,
                    );

                    Navigator.of(context).pop(); // Remove loading indicator

                    final resBody = jsonDecode(res.body);

                    if (res.statusCode == 200 || res.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Registration successful!"),
                          backgroundColor: Color(0xFF10B981),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Registration failed! ${resBody["message"]}"),
                          backgroundColor: const Color(0xFFEF4444),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color:  Color.fromRGBO(14, 161, 125, 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}