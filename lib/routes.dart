import 'package:flutter/material.dart';
import 'main_views/dashboard_page.dart';
import 'main_views/forgot_password_page.dart';
import 'main_views/login_page.dart';
import 'main_views/register_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {

    // Authentication

    case '/':
      return MaterialPageRoute(builder: (BuildContext context) => LoginPage());
    case '/auth/register/':
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return RegisterPage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    case '/auth/password/reset/':
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return ForgotPasswordPage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          var begin = const Offset(-1.0, 0.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );

    // Body

    case '/dashboard':
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return DashboardPage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return ScaleTransition(scale: animation, child: child);
        },
      );
  }
}
