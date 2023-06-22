import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at the top left corner
    path.lineTo(0, size.height * 0.5);

    final firstControlPoint = Offset(size.width * 0.25, size.height * 0.3);
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.5);
    final secondEndPoint = Offset(size.width, size.height * 0.4);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Connect to the top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper2 extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at the top left corner
    path.lineTo(0, size.height * 0.5);

    final firstControlPoint = Offset(size.width * 0.25, size.height * 0.1);
    final firstEndPoint = Offset(size.width * 0.45, size.height * 0.4);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.75);
    final secondEndPoint = Offset(size.width, size.height * 0.5);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Connect to the top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

