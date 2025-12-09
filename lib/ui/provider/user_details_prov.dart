import 'package:flutter/material.dart';
import 'package:task_1/enums/user_fetch_state.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/network/user_service.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserModel? _user;
  String _errorMessage = "";
  UserFetchState _userFetchState = UserFetchState.initial;

  UserModel? get user => _user;
  String get errorMessage => _errorMessage;
  UserFetchState get userFetchState => _userFetchState;

  Future<void> fetchUser(String id) async {
    
    // To not allow multiple requests at the same time
    if(_userFetchState == UserFetchState.loading) return;

    // To not allow empty id
    if (id.isEmpty || int.tryParse(id) == null) {
      _setErrorState(msg: "Enter a valid id");
      return;
    }
    
    try {
      _userFetchState = UserFetchState.loading;
      notifyListeners();
      
      // Get user model from api
      final ApiResponse response = await UserService.fetchUser(id);

      // sets user fetch state to error if success is false
      if (response.success == false) {
        _setErrorState(msg: response.error.toString());
        return;
      }

      // sets user fetch state to error if data or user model is null
      if (response.data == null || response.data?.user == null) {
        _setErrorState();
        return;
      }

      // sets user fetch state to success and assigns user model to user
      _userFetchState = UserFetchState.success;
      _user = response.data!.user!;
      notifyListeners();

    } on Exception catch (_) {
      _setErrorState();
    }
  }

  void clearProvider(){
    _userFetchState = UserFetchState.initial;
    _user = null;
    _errorMessage = "";
    notifyListeners();
  }

  _setErrorState({String? msg}) {
    _userFetchState = UserFetchState.error;
    _errorMessage = msg ?? "Something went wrong";
    notifyListeners();
  }
}
