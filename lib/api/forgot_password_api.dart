import 'dart:convert';
import 'package:home_owners_application_version_one/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

Future<dynamic> sendEmailConfirmation(String email) async{

  var url = Uri.parse('$baseUrl/password/reset/');
  var response = await http.post(
    url,
    body: {
      'email': email,
    },
  );

  print(response.body);

  if (response.statusCode == 200){
    return response.body;
  } else {
    return response.body;
  }



}