import 'package:flutter/material.dart';

class CommonTextFormFieldOutlined extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validator;
  final bool obscureText;

  const CommonTextFormFieldOutlined({
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.obscureText,
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
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xFF523AA8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xFFd0d0f0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      ),
    );
  }
}
