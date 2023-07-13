import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:home_owners_application_version_one/api/google_auth_api.dart';
import 'package:home_owners_application_version_one/components/common_components.dart';

import '../constants.dart';
import '../models/models.dart';
import '../api/logout_api.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  @override
  Widget build(BuildContext context) {

    EmailUser user = context.read<UserCubit>().state;
    // GoogleUser googleUserAccount = context.read<GoogleUserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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

            CommonElevatedButton(
                buttonText: 'Log Out',
                buttonColor: const Color(0xFF523AA8),
                onPressed: (){
                  googleSignOut();
                  logoutUser();
                  Navigator.pop(context);
                },
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
