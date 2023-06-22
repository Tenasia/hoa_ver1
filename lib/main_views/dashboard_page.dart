import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_owners_application_version_one/models/users_cubit.dart';

import '../models/users_model.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {

  @override
  Widget build(BuildContext context) {

    EmailUser user = context.read<UserCubit>().state;


    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the dashboard!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Email: ${user?.email} ${user?.first_name} ${user?.middle_name} ${user?.last_name}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}