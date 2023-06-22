import 'dart:convert';
import 'package:home_owners_application_version_one/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:home_owners_application_version_one/models/users_model.dart';


const ipAddress = '192.168.68.113';
const djangoAddress = '10.0.0.2';
const baseUrl = "http://$ipAddress:8000/user";

  // Authenticates what the user has entered, grab the key that it returned
  // if successful, it returns a token that is then used to authenticate the
  // login

  Future<dynamic> loginUserAuth(String email, String password) async{

    var url = Uri.parse('$baseUrl/login/');
    var response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200){
      Map json = jsonDecode(response.body);
      String token = json['key'];

      // Saves the token as the key session
      var box = await Hive.openBox(tokenBox);
      box.put("token", token);

      EmailUser? user = await getUser(token);

      return user;
    } else {
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
    }
  }

  // Grabs the user in the database with their information if token matches
  Future<EmailUser?> getUser(String token) async{
    var url = Uri.parse('$baseUrl/userInformation/');
    var response = await http.get(
        url,
        headers: {
          'Authorization': 'Token ${token}',
        }
    );

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      EmailUser user = EmailUser.fromJson(json);

      print(json);
      user.token = token;
      return user;
    } else{
      print('Log in failed.');
      return null;
    }
  }

