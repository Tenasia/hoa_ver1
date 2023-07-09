import 'package:flutter/cupertino.dart';

class HorizontalWaveClipper extends CustomClipper<Path> {

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

class HorizontalWaveClipper2 extends CustomClipper<Path> {

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

class VerticalWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at the top left corner
    path.lineTo(size.width * 0.5, 0);

    final firstControlPoint = Offset(size.width * 0.3, size.height * 0.25);
    final firstEndPoint = Offset(size.width * 0.4, size.height * 0.5);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.5, size.height * 0.75);
    final secondEndPoint = Offset(size.width * 0.4, size.height);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(0, size.height); // Connect to the bottom left corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class VerticalWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at the top left corner
    path.lineTo(size.width * 0.5, 0);

    final firstControlPoint = Offset(size.width * 0.1, size.height * 0.25);
    final firstEndPoint = Offset(size.width * 0.4, size.height * 0.45);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.5);
    final secondEndPoint = Offset(size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(0, size.height); // Connect to the bottom left corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}


class HorizontalCustomWaveDesign extends StatelessWidget {
  final List<Color> gradientColors;

  final double firstWaveHeight;
  final double firstWaveWidth;

  final double secondWaveHeight;
  final double secondWaveWidth;

  const HorizontalCustomWaveDesign({
    Key? key,
    required this.gradientColors,

    required this.firstWaveHeight,
    required this.firstWaveWidth,

    required this.secondWaveHeight,
    required this.secondWaveWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: HorizontalWaveClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
            ),
            height: firstWaveHeight,
            width: firstWaveWidth,
          ),
        ),
        ClipPath(
          clipper: HorizontalWaveClipper2(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
            ),
            height: secondWaveHeight,
            width: secondWaveWidth,
          ),
        ),
      ],
    );
  }
}

class VerticalCustomWaveDesign extends StatelessWidget {
  final List<Color> gradientColors;

  final double firstWaveHeight;
  final double firstWaveWidth;

  final double secondWaveHeight;
  final double secondWaveWidth;

  const VerticalCustomWaveDesign({
    Key? key,
    required this.gradientColors,
    required this.firstWaveHeight,
    required this.firstWaveWidth,
    required this.secondWaveHeight,
    required this.secondWaveWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: -90 * 3.1415927 / 180, // Rotate the widget by -90 degrees
          child: ClipPath(
            clipper: VerticalWaveClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
              ),
              height: firstWaveWidth, // Swap width and height
              width: firstWaveHeight, // Swap width and height
            ),
          ),
        ),
        Transform.rotate(
          angle: -90 * 3.1415927 / 180, // Rotate the widget by -90 degrees
          child: ClipPath(
            clipper: VerticalWaveClipper2(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
              ),
              height: secondWaveWidth, // Swap width and height
              width: secondWaveHeight, // Swap width and height
            ),
          ),
        ),
      ],
    );
  }
}




