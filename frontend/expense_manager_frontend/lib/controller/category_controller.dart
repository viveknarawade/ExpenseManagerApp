import 'dart:developer';
import 'dart:io';
import 'package:expense_manager_frontend/model/user.dart';
import 'package:expense_manager_frontend/user_session.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  Future<void> addCategory(String? categoryImg, String categoryName) async {
    try {
      log("Category image : $categoryImg");

      var uri = Uri.parse('http://192.168.84.128:8080/api/v1/categories');
      var request = http.MultipartRequest('POST', uri);

      // Add Authorization Header
      final token = UserSession.user?.getAccessToken();

      if (token == null) {
        throw Exception("User is not logged in. Token is missing.");
      }

      log("FRONTEND Access Token: $token");

      request.headers['Authorization'] = 'Bearer $token';

      // Add field
      request.fields['name'] = categoryName;

      // Add image file
      if (categoryImg != null) {
        var file = await http.MultipartFile.fromPath('image', categoryImg);
        request.files.add(file);
      }

      // Send request
      var response = await request.send();
      final resBody = await http.Response.fromStream(response);

      log("Response status: ${resBody.statusCode}");
      log("Response body: ${resBody.body}");
    } catch (e) {
      log("Error during category add: $e");
    }
  }
}
