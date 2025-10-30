import 'package:fpdart/fpdart.dart';
import 'package:task_1/exceptions/custom_exception.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/network/user_service.dart';

Future<Either<CustomException, User>> fetchUser(String id) async {
  final Either<CustomException, UserModel> response = await UserService.fetchUser(id);
  return response.fold((e) => Either.left(e), (userModel) => Either.right(userModel.data!.user!));
}
