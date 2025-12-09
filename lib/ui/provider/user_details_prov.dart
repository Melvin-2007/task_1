import 'package:flutter/material.dart';
import 'package:task_1/enums/user_fetch_state.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/network/user_service.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserModel? user;
  String errorMessage = "";
  UserFetchState userFetchState = UserFetchState.initial;

  Future<void> fetchUser(String id) async {
    // To not allow multiple requests at the same time
    if (userFetchState == UserFetchState.loading) return;

    // To not allow empty id
    if (id.isEmpty || int.tryParse(id) == null) {
      setErrorState(msg: "Enter a valid id");
      return;
    }
    userFetchState = UserFetchState.loading;
    notifyListeners();
    try {
      // Get user model from api
      final ApiResponse response = await UserService.fetchUser(id);

      // sets user fetch state to error if success is false
      if (response.success == false) {
        setErrorState(msg: response.error.toString());
        return;
      }

      // sets user fetch state to error if data or user model is null
      if (response.data == null || response.data?.user == null) {
        setErrorState();
        return;
      }

      // sets user fetch state to success and assigns user model to user
      userFetchState = UserFetchState.success;
      user = response.data!.user!;
      notifyListeners();
    } on Exception catch (_) {
      setErrorState();
    }
  }

  void clearProvider() {
    userFetchState = UserFetchState.initial;
    user = null;
    errorMessage = "";
  }

  setErrorState({String? msg}) {
    userFetchState = UserFetchState.error;
    errorMessage = msg ?? "Something went wrong";
    notifyListeners();
  }
}
