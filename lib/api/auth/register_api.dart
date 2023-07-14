import 'dart:convert';
import 'package:home_owners_application_version_one/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:home_owners_application_version_one/models/model/users_model.dart';

  Future<dynamic> registerUserAuth(
      String firstName,
      String middleName,
      String lastName,
      String email,
      String password1,
      String password2,
      ) async{
    var url = Uri.parse('$baseUrl/register/');

    var response = await http.post(
      url,
      body: {
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'email': email,
        'password1': password1,
        'password2': password2,
      },
    );

    if (response.statusCode == 204){
      return null;
    } else if (response.body.isNotEmpty) {
      Map json = jsonDecode(response.body);

      if (json.containsKey("email")){
        return json["email"][0];
      }
      if (json.containsKey("password")) {
        return json["password"][0];
      }
      if (json.containsKey("non_field_errors")) {
        return json["non_field_errors"][0];
      }
    } else {
      return null;
    }
  }