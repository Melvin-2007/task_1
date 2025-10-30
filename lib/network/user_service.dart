import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:task_1/exceptions/custom_exception.dart';
import 'package:task_1/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = "https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock/users";

  static Future<Either<CustomException, UserModel>> fetchUser(String id) async {
    final String url = "$_baseUrl/$id";
    try {
      final response = await http.get(Uri.parse(url));
      // response status 200
      if (response.statusCode == 200) {
        return Either.right(UserModel.fromJson(jsonDecode(response.body)));
      }
      // response status 404
      else if (response.statusCode == 404) {
        final UserModel model = UserModel.fromJson(jsonDecode(response.body));
        return Either.left(CustomException(message: model.error!));
      }
      // any other response
      else {
        return Either.left(CustomException(message: "Something went wrong"));
      }
    } catch (e) {
      log(e.toString());
      return Either.left(CustomException(message: "Something went wrong"));
    }
  }
}
