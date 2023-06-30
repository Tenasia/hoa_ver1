import 'package:home_owners_application_version_one/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';


Future<dynamic> logoutUser() async{

  final box = await Hive.openBox(tokenBox);
  String? token = box.get('token');

  var url = Uri.parse('$baseUrl/logout/');
  var response = await http.post(
    url,
    headers: {'Authorization': 'Token $token'}, // Pass the token in the Authorization header
  );

  return response.body;
}