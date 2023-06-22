import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_owners_application_version_one/models/google_users_model.dart';

// A Cubit for handling the user states, it is basically a global scope for it
class GoogleUserCubit extends Cubit<GoogleUser>{
  GoogleUserCubit(super.initialState);
}
