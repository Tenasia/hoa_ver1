import 'dart:convert';
import 'package:home_owners_application_version_one/constants.dart';
import 'package:http/http.dart' as http;

Future<dynamic> sendEmailConfirmation(String email) async {
  var url = Uri.parse('$baseUrl/password/reset/');
  var response = await http.post(
    url,
    body: {
      'email': email,
    },
  );

  print(response.body);

  if (response.statusCode == 200) {

    dynamic jsonResponse = jsonDecode(response.body);
    var loggedIn = jsonResponse["detail"];
    return loggedIn;
  } else {
    dynamic jsonResponse = jsonDecode(response.body);

    if (jsonResponse is List) {
      String errorMessage = jsonResponse[0];
      return errorMessage;
    } else if (jsonResponse is Map) {
      if (jsonResponse.containsKey("email")) {
        if (jsonResponse["email"] is List) {
          return jsonResponse["email"][0];
        } else {
          return jsonResponse["email"];
        }
      }

      if (jsonResponse.containsKey("non_field_errors")) {
        if (jsonResponse["non_field_errors"] is List) {
          return jsonResponse["non_field_errors"][0];
        } else {
          return jsonResponse["non_field_errors"];
        }
      }
      return null;
    } else {
      // Handle any other unexpected response type
      print("Unexpected response type: ${jsonResponse.runtimeType}");
      return null; // Or any other appropriate error handling
    }
  }
}
