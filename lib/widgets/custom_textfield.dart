import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFC49E3C), // Default Brand Gold
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final String label;
//   final IconData icon;
//   final bool isPassword;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;

//   const CustomTextField({
//     super.key,
//     required this.label,
//     required this.icon,
//     required this.controller,
//     this.isPassword = false,
//     this.validator,
//   });

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {

//   bool obscureText = true;

//   @override
//   Widget build(BuildContext context) {

//     return TextFormField(
//       controller: widget.controller,
//       obscureText: widget.isPassword ? obscureText : false,
//       validator: widget.validator,

//       decoration: InputDecoration(
//         labelText: widget.label,

//         prefixIcon: Icon(widget.icon),

//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),

//         /// 👁 SHOW / HIDE PASSWORD
//         suffixIcon: widget.isPassword
//             ? IconButton(
//                 icon: Icon(
//                   obscureText
//                       ? Icons.visibility_off
//                       : Icons.visibility,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     obscureText = !obscureText;
//                   });
//                 },
//               )
//             : null,
//       ),
//     );
//   }
// }