import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_owners_application_version_one/models/users_model.dart';

// A Cubit for handling the user states, it is basically a global scope for it
class UserCubit extends Cubit<EmailUser>{
  UserCubit(super.initialState);
}
