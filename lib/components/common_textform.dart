import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final String validator;

  const CommonTextFormField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if (value == null || value.isEmpty){
          return validator;
        }
      },
      controller: controller,
      cursorColor: const Color(0xFF523AA8),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: ColorFiltered(
          colorFilter: FocusNode().hasFocus
              ? const ColorFilter.mode(Color(0xFF523AA8), BlendMode.srcIn)
              : const ColorFilter.mode(Color(0xFF523AA8), BlendMode.srcIn),
          child: prefixIcon,
        ),
        contentPadding: const EdgeInsets.only(top: 13.5),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF523AA8), width: 2.0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE6E6FA), width: 2.0),
        ),
      ),
      style: TextStyle(
        color: Colors.grey[800],
      ),
    );
  }
}
