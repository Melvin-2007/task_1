import 'package:flutter/material.dart';
import 'package:task_1/enums/user_fetch_state.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/network/user_service.dart';
import 'package:task_1/widgets/user_details_card_builder.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  static late TextEditingController _textEditingController;
  static User? _user;
  static late String _errorMessage;
  static late UserFetchState _userFetchState;

  @override
  void initState() {
    _userFetchState = UserFetchState.initial;
    _errorMessage = "";
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(200, 0, 200, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hint: Text("User ID", style: TextStyle(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => _fetchUser(),
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                child: Text("Fetch User", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              UserDetailsCardBuilder(user: _user, userFetchState: _userFetchState, errorMessage: _errorMessage),
            ],
          ),
        ),
      ),
    );
  }

  _fetchUser() async {
    setState(() {
      _userFetchState = UserFetchState.loading;
    });
    final String id = _textEditingController.text.trim();

    if (id.isEmpty) {
      _setErrorState(msg: "Enter a valid id");
      return;
    }

    try {
      final UserModel userModel = await UserService.fetchUser(id);

      // sets user fetch state to error if success is false
      if (userModel.success == false) {
        _setErrorState(msg: userModel.error.toString());
        return;
      }
      
      // sets user fetch state to error if data or user model is null
      if (userModel.data == null || userModel.data?.user == null) {
        _setErrorState();
        return;
      }

      setState(() {
        _userFetchState = UserFetchState.success;
        _user = userModel.data!.user!;
      });

    } on Exception catch (_) {
      _setErrorState();
    }
  }

  _setErrorState({String? msg}) {
    setState(() {
      _userFetchState = UserFetchState.error;
      _errorMessage = msg ?? "Something went wrong";
    });
  }
}
