import 'dart:convert';
import 'dart:developer';

import 'package:expense_manager_frontend/model/user.dart';
import 'package:http/http.dart' as http;

class UserController {

  
  Future<dynamic> loginUser(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('http://192.168.84.128:8080/api/v1/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final userData = jsonDecode(res.body)["data"];

      User(userData["_id"], userData["userName"], userData["email"], userData["avatar"]);
      // User(resBody, userName, email, avatar)
      log(" res body :  ${userData["userName"]}");
      return res;
    } catch (e) {
      log("Error during login: $e");
    }
  }

  Future<dynamic> registerUser(String userName, String email, String password,
      String? avatarImgPath) async {
    try {
      var uri = Uri.parse('http://192.168.84.128:8080/api/v1/users/register');

      var request = http.MultipartRequest('POST', uri);

      // Add text fields
      request.fields['userName'] = userName;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Attach the file if not null
      if (avatarImgPath != null) {
        var file = await http.MultipartFile.fromPath('avatar', avatarImgPath);
        request.files.add(file);
      }

      var response = await request.send();
      final resBody = await http.Response.fromStream(response);

      log("Response status: ${resBody.statusCode}");
      log("Response body: ${resBody.body}");
      return resBody;
    } catch (e) {
      log("Error during register: $e");
      return false;
    }
  }
}
