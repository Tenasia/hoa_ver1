import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_owners_application_version_one/main_views/login_page.dart';
import 'package:home_owners_application_version_one/models/users_cubit.dart';
import 'models/users_model.dart';

void main() async {
  // this is the initialization part of the app
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const HomeOwnerApp());
}

// App Name
class HomeOwnerApp extends StatelessWidget {

  const HomeOwnerApp({super.key});

  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (context){
        return UserCubit(EmailUser());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: LoginPage()
      ),
    );
  }

}