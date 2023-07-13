import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_owners_application_version_one/models/users_cubit.dart';
import 'package:home_owners_application_version_one/models/users_model.dart';
import 'routes.dart';

void main() async {
  // this is the initialization part of the app
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(HomeOwnerApp());
}

class HomeOwnerApp extends StatelessWidget {
  HomeOwnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserCubit(EmailUser());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
