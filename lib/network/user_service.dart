import 'dart:convert';
import 'dart:developer';

import 'package:task_1/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = "https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock/users";

  static Future<UserModel> fetchUser(String id) async {
    final String url = "$_baseUrl/$id";
    try {
      final response = await http.get(Uri.parse(url));
      log(response.statusCode.toString());
      // checks if status code is 200 or 404 and return User model
      if (response.statusCode == 200 || response.statusCode == 404) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
