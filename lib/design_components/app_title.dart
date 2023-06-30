import 'package:flutter/material.dart';

class CustomTitleRow extends StatelessWidget {
  final String title;

  const CustomTitleRow({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF523AA8), Color(0xFF523AA8)],
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.house_outlined,
              color: Color(0xFFE6E6FA),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
