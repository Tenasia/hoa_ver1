import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseHelper {
  static String ipAddress = '192.168.68.105';

  static Future<List<dynamic>> getBlogs(int blog_id) async {

    final csrfResponse = await http.get(Uri.parse('http://10.0.2.2:8000/blog/get_csrf_token/'));
    final csrfToken = csrfResponse.headers['set-cookie'];
    print(csrfToken);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/blog/getBlogs'),
      // headers: {
      //   'X-CSRFToken': 'test',
      // },
      body: {
        'blog_id': blog_id.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final users = data['data'] as List<dynamic>;

      return users;
      // return users;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
// void fetchData() async {
//   const dataUrl = 'http://10.0.2.2:8000/projects/';
//
//   Dio dio = Dio();
//   // dio.interceptors.add(CookieManager());
//
//   try {
//     var response = await dio.get(dataUrl);
//
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.data) as Map<String, dynamic>;
//       var projects = jsonData['projects'] as List<dynamic>;
//       //
//       // final data = json.decode(response.body) as Map<String, dynamic>;
//       // final users = data['data'] as List<dynamic>;
//
//       // Access and handle the project data
//       for (var project in projects) {
//         var projectId = project['id'];
//         var projectTitle = project['title'];
//         var projectDescription = project['description'];
//         var projectTechnology = project['technology'];
//         var projectImage = project['image'];
//
//         // Do something with the project data
//         print('Project ID: $projectId');
//         print('Title: $projectTitle');
//         print('Description: $projectDescription');
//         print('Technology: $projectTechnology');
//         print('Image: $projectImage');
//       }
//     } else {
//       // Handle non-200 status code
//       print('Error: ${response.statusCode}');
//     }
//   } catch (error) {
//     // Handle any errors that occur during the request
//     print('Error: $error');
//   }
// }

