import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/auth/login_screen.dart' show LoginScreen;
import 'package:royalpetals/widgets/custom_button.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _agreeToTerms = false;

  // Controllers to get data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.07;
    const Color brandGold = Color(0xFFC49E3C);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // Logo Placeholder (Using Text since I don't have your asset)
                Center(
                  child: Text(
                    'TRP',
                    style: TextStyle(
                      fontFamily: 'Cursive',
                      fontSize: size.width * 0.12,
                      color: brandGold.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Create your new account!',
                  style: TextStyle(
                    fontSize: size.width * 0.065,
                    fontWeight: FontWeight.bold,
                    color: brandGold,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Please enter your email and password\n to create your account.',
                  textAlign: TextAlign.left,
                  style:GoogleFonts.cabin(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
                ),
                const SizedBox(height: 30),

                // Full Name Field
                _buildLabel("Full Name"),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration("ABC"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter your name" : null,
                ),
                const SizedBox(height: 20),

                // Email Field
                _buildLabel("Email"),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration("abc@gmail.com"),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                _buildLabel("Password"),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: _inputDecoration("●●●●●●●●").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                    ),
                  ),
                  validator: (value) =>
                      value!.length < 6 ? "Password must be 6+ chars" : null,
                ),
                const SizedBox(height: 15),

                // Terms & Conditions
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      activeColor: brandGold,
                      onChanged: (val) => setState(() => _agreeToTerms = val!),
                    ),
                    Expanded(
                      child: Text(
                        "I am agree to Terms & Condition, Privacy Policy",
                        style: GoogleFonts.cabin(
                          fontWeight: FontWeight.w500,
                          color:
                              Colors.black, // This sets the text color to black
                          fontSize:
                              12, // Optional: adjust size to match your Figma
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Divider "or with"
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.black,)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or with",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 25),

                // Social Buttons
                Row(
                  children: [
                    _socialButton(
                      "Google",
                      "assets/image/google_icon.png",
                    ), // Add your icon
                    const SizedBox(width: 15),
                    _socialButton(
                      "Apple",
                      "assets/image/apple_icon.png",
                    ), // Add your icon
                  ],
                ),
                const SizedBox(height: 30),

                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Continue as Guest",
                      style: TextStyle(
                        color: brandGold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Bottom Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.cabin(
                        fontWeight: FontWeight.w400,
                        color:
                            Colors.black, // This sets the text color to black
                        fontSize:
                            15, // Optional: adjust size to match your Figma
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
                      child:  Text(
                        "Login",
                         style: GoogleFonts.cabin(
                        fontWeight: FontWeight.w600,
                        color:
                            Colors.black, // This sets the text color to black
                        fontSize:
                            14, // Optional: adjust size to match your Figma
                      ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: CustomButton(
                    title: "Register",
                    onPressed: () {
                      Get.toNamed(AppRoutes.mainNav);
                      // if (_formKy.currentState!.validate() && _agreeToTerms) {
                      //   // Your registration logic
                      // }
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: GoogleFonts.cabin(
            fontWeight: FontWeight.w500,
            color: Colors.black, // This sets the text color to black
            fontSize: 14, // Optional: adjust size to match your Figma
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _socialButton(String label, String iconPath) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for real icons
            Icon(
              label == "Google" ? Icons.g_mobiledata : Icons.apple,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:royalpetals/widgets/custom_button.dart';
// import 'package:royalpetals/widgets/custom_textfield.dart';

// class SignupScreen extends StatelessWidget {
//   SignupScreen({super.key});

//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,

//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff7B1FA2), Color(0xffBA68C8)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),

//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               width: size.width > 700 ? 420 : size.width * 0.9,
//               padding: const EdgeInsets.all(30),

//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: const [
//                   BoxShadow(blurRadius: 20, color: Colors.black12),
//                 ],
//               ),

//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     const Icon(
//                       Icons.local_florist,
//                       size: 70,
//                       color: Colors.purple,
//                     ),

//                     const SizedBox(height: 15),

//                     const Text(
//                       "Create Account",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     CustomTextField(
//                       label: "Full Name",
//                       icon: Icons.person,
//                       controller: nameController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Name is required";
//                         }
//                         if (value.length < 3) {
//                           return "Enter valid name";
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 20),

//                     CustomTextField(
//                       label: "Email",
//                       icon: Icons.email_outlined,
//                       controller: emailController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Email required";
//                         }
//                         if (!value.contains("@")) {
//                           return "Enter valid email";
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 20),

//                     CustomTextField(
//                       label: "Password",
//                       icon: Icons.lock_outline,
//                       controller: passwordController,
//                       isPassword: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Password required";
//                         }
//                         if (value.length < 6) {
//                           return "Minimum 6 characters";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 25),

//                     CustomButton(
//                       title: "Sign Up",
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           Get.snackbar(
//                             "Success",
//                             "Account Created",
//                             backgroundColor: Colors.white,
//                           );
//                         }
//                       },
//                     ),

//                     const SizedBox(height: 20),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Already have an account? "),

//                         GestureDetector(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.purple,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
