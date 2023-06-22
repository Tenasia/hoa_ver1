import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_owners_application_version_one/models/google_users_model.dart';
import 'package:home_owners_application_version_one/models/users_cubit.dart';
import 'package:home_owners_application_version_one/models/google_users_cubit.dart';

import '../models/users_model.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {

  @override
  Widget build(BuildContext context) {

    EmailUser user = context.read<UserCubit>().state;
    // GoogleUser googleUserAccount = context.read<GoogleUserCubit>().state;



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
              'Common Email: ${user?.email} ${user?.first_name} ${user?.middle_name} ${user?.last_name}',
              style: TextStyle(fontSize: 16),
            ),
            // Text(
            //   'Google Email: ${googleUserAccount?.email} ${googleUserAccount?.displayName} ${googleUserAccount?.id} ${googleUserAccount?.photoUrl}',
            //   style: TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
