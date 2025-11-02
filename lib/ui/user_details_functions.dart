part of 'user_details_screen.dart';

Future<Either<UserFetchException, User>> fetchUserDetails(String id) async {
  final Either<UserFetchException, UserModel> response = await UserService.fetchUser(id);
  return response.fold((e) => Either.left(e), (userModel) => Either.right(userModel.data!.user!));
}
