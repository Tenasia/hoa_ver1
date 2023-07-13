import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

final Map<String, WidgetBuilder> routes = {

  // Authentication

  '/auth': (BuildContext context) => LoginPage(),
  '/auth/register/': (BuildContext context) => RegisterPage(),
  '/auth/password/reset/':(BuildContext context) => ForgotPasswordPage(),

  // Body

  '/dashboard': (BuildContext context) => DashboardPage(),


};

