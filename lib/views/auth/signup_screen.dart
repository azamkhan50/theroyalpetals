import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/widgets/custom_button.dart';
import 'package:royalpetals/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff7B1FA2), Color(0xffBA68C8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: size.width > 700 ? 420 : size.width * 0.9,
              padding: const EdgeInsets.all(30),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 20, color: Colors.black12),
                ],
              ),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(
                      Icons.local_florist,
                      size: 70,
                      color: Colors.purple,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    CustomTextField(
                      label: "Full Name",
                      icon: Icons.person,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        if (value.length < 3) {
                          return "Enter valid name";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      label: "Email",
                      icon: Icons.email_outlined,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email required";
                        }
                        if (!value.contains("@")) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      label: "Password",
                      icon: Icons.lock_outline,
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password required";
                        }
                        if (value.length < 6) {
                          return "Minimum 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),

                    CustomButton(
                      title: "Sign Up",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Get.snackbar(
                            "Success",
                            "Account Created",
                            backgroundColor: Colors.white,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),

                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
