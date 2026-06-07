


import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/auth/signup_screen.dart' show SignUpScreen;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/widgets/custom_button.dart';

import '../../controller/ShopifyLoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Ensure your path to the controller is correct

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Use Get.put if this is the first time the controller is created
  final ShopifyLoginController authController = Get.put(ShopifyLoginController());

  static const Color brandGold = Color(0xFFC39A38);
  static const Color shopifyBlue = Color(0xFF005BD3);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              // Logo - Royal Petals Branding
              const Center(
                child: Text(
                  'TRP', 
                  style: TextStyle(
                    fontFamily: 'Cursive', 
                    fontSize: 54, 
                    color: brandGold, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Center(
                child: Text("Sign in", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text("Sign in or create an account", style: TextStyle(color: Colors.black54, fontSize: 14)),
              ),

              const SizedBox(height: 40),

              // "Continue with Shop" Button
              // OutlinedButton.icon(
              //   style: OutlinedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(vertical: 14),
              //     side: BorderSide(color: Colors.grey.shade300),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //   ),
              //   icon: const Icon(Icons.shopping_bag, color: Colors.deepPurple), 
              //   label: const Text("Continue with Shop", style: TextStyle(color: Colors.black)),
              //   onPressed: authController.isLoggingIn.value 
              //       ? null 
              //       : () => authController.loginWithEmail(),
              // ),
              
              // const SizedBox(height: 25),
              // _buildDivider(),
              // const SizedBox(height: 25),

              // Email Input
              _buildTextField(
                label: "Email",
                hint: "example@email.com",
                onChanged: (val) => authController.email.value = val,
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 20),
              
              // Action Button (Continue)
              _buildActionButton("Continue", () {
                if (authController.email.value.isNotEmpty) {
                  authController.loginWithEmail();
                } else {
                  Get.snackbar("Required", "Please enter your email", 
                      snackPosition: SnackPosition.BOTTOM, 
                      backgroundColor: Colors.orangeAccent);
                }
              }),

              const SizedBox(height: 40),
              Center(
                child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.mainNav),
                  child: const Text(
                    "Continue as Guest", 
                    style: TextStyle(
                      color: brandGold, 
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildTextField({
    required String label, 
    String? hint, 
    required Function(String) onChanged, 
    TextInputType? keyboardType
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), 
          borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), 
          borderSide: const BorderSide(color: shopifyBlue, width: 2)
        ),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: authController.isLoggingIn.value 
        ? const Center(child: CircularProgressIndicator(color: shopifyBlue))
        : CustomButton(
                    title: text,
                    onPressed: onPressed
                  )
        
        //  ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: shopifyBlue,
        //       padding: const EdgeInsets.symmetric(vertical: 16),
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //       elevation: 0,
        //     ),
        //     onPressed: onPressed,
        //     child: Text(
        //       text, 
        //       style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
        //     ),
        //   ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Text("or", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscured = true;

//   // Controllers
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // Your specific Brand Gold Color
//   static const Color brandGold = Color(0xFFC39A38);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final double horizontalPadding = size.width * 0.08;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9), // Light background from Figma
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),
//                 // Logo Placeholder (Using Text since I don't have your asset)
//                 Center(
//                   child: Text(
//                     'TRP',
//                     style: TextStyle(
//                       fontFamily: 'Cursive',
//                       fontSize: size.width * 0.12,
//                       color: brandGold.withOpacity(0.7),
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Welcome Text
//                 Text(
//                   'Welcome Back!',
//                   style: TextStyle(
//                     fontSize: size.width * 0.075,
//                     fontWeight: FontWeight.bold,
//                     color: brandGold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Please enter your email and password\nto access your account.',
//                   style: TextStyle(color: Colors.black, height: 1.4),
//                 ),

//                 const SizedBox(height: 40),

//                 // Email Field
//                 Text(
//                   "Email",
//                   style: GoogleFonts.cabin(fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: _inputDecoration("abc@gmail.com"),
//                   validator: (value) {
//                     if (value == null || !value.contains('@')) {
//                       return "Please enter a valid email";
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 25),

//                 // Password Field
//                 Text(
//                   "Password",
//                   style: GoogleFonts.cabin(fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: _isObscured,
//                   decoration: _inputDecoration("●●●●●●●●").copyWith(
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscured ? Icons.visibility_off : Icons.visibility,
//                       ),
//                       onPressed: () =>
//                           setState(() => _isObscured = !_isObscured),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.length < 6 ? "Password is too short" : null,
//                 ),

//                 const SizedBox(height: 10),

//                 // Forgot Password
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       "Forgot Password?",
//                       style: GoogleFonts.cabin(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Divider Row
//                 Row(
//                   children: const [
//                     Expanded(child: Divider(color: Colors.black)),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         "or with",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     Expanded(child: Divider(color: Colors.black)),
//                   ],
//                 ),

//                 const SizedBox(height: 25),

//                 // Social Buttons
//                 Row(
//                   children: [
//                     _socialButton("Google", Icons.g_mobiledata),
//                     const SizedBox(width: 15),
//                     _socialButton("Apple", Icons.apple),
//                   ],
//                 ),

//                 const SizedBox(height: 30),

//                 // Continue as Guest
//                 Center(
//                   child: TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "Continue as Guest",
//                       style: TextStyle(
//                         color: brandGold,
//                         decoration: TextDecoration.underline,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 // Bottom Register Link
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                      Text("Don't have an account? ",style: GoogleFonts.cabin(
//     fontWeight: FontWeight.w400,
//     color: Colors.black, // This sets the text color to black
//     fontSize: 14,        // Optional: adjust size to match your Figma
//   ),),
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(() => const SignUpScreen());
//                         // Navigate to Register Screen
//                       },
//                       child:  Text(
//                         "Register",
//                        style: GoogleFonts.cabin(
//     fontWeight: FontWeight.w500,
//     color: Colors.black, // This sets the text color to black
//     fontSize: 14,        // Optional: adjust size to match your Figma
//   ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // Reusable Log in Button
//                 CustomButton(
//                   text: "Log in",
//                   onPressed: () {
//                        Get.toNamed(AppRoutes.mainNav);
//                     // if (_formKey.currentState!.validate()) {
//                     //   // Login Logic Here
//                     // }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Input Field Style
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   // Social Button Widget
//   Widget _socialButton(String label, IconData icon) {
//     return Expanded(
//       child: Container(
//         height: 55,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 28),
//             const SizedBox(width: 8),
//             Text(label, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // CustomButton Widget defined separately for reuse
// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;

//   const CustomButton({super.key, required this.text, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFC39A38),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           elevation: 0,
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:royalpetals/views/auth/signup_screen.dart';
// import 'package:royalpetals/views/home/home_screen.dart';
// import 'package:royalpetals/widgets/custom_button.dart';
// import 'package:royalpetals/widgets/custom_textfield.dart';

// class LoginScreen extends StatelessWidget {

//   LoginScreen({super.key});

//   final _formKey = GlobalKey<FormState>();

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
//             colors: [
//               Color(0xff7B1FA2),
//               Color(0xffBA68C8),
//             ],
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
//                   BoxShadow(
//                     blurRadius: 20,
//                     color: Colors.black12,
//                   )
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

//                     const SizedBox(height: 20),

//                     const Text(
//                       "Welcome Back",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     CustomTextField(
//                       label: "Email",
//                       icon: Icons.email_outlined,
//                       controller: emailController,
//                       validator: (value) {

//                         if (value == null || value.isEmpty) {
//                           return "Email is required";
//                         }

//                         if (!value.contains("@")) {
//                           return "Enter valid email";
//                         }

//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 20),
// CustomTextField(
//   label: "Password",
//   icon: Icons.lock_outline,
//   controller: passwordController,
//   isPassword: true,
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return "Password required";
//     }
//     if (value.length < 6) {
//       return "Minimum 6 characters";
//     }
//     return null;
//   },
// ),

//                     const SizedBox(height: 25),

//                     CustomButton(
//                       title: "Login",
//                       onPressed: () {
// Get.to(() => HomeScreen());
//                         // if (_formKey.currentState!.validate()) {

//                         //   Get.snackbar(
//                         //     "Success",
//                         //     "Login Successful",
//                         //   );

//                         // }

//                       },
//                     ),

//                     const SizedBox(height: 20),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [

//                         const Text("Don't have an account? "),

//                         GestureDetector(
//                           onTap: () {
//                           //  Get.to(() =>  SignupScreen());
//                           },

//                           child: const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                               color: Colors.purple,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         )
//                       ],
//                     )
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