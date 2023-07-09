import 'package:flutter/material.dart';

class CommonInfoLogDisplay extends StatelessWidget {
  final Text text;

  const CommonInfoLogDisplay({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Center(child: text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
