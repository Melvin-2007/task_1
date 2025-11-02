import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Either;
import 'package:task_1/exceptions/user_fetch_exception.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/network/user_service.dart';
import 'package:task_1/widgets/user_details_card.dart';

part 'user_details_functions.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: UserDetailsScreen());
}

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  static late TextEditingController _textEditingController;
  static Future<Either<UserFetchException, User>>? _fetchUser;
  @override
  void initState() {
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
                onPressed: () {
                  final String id = _textEditingController.text.trim();
                  setState(() {
                    _fetchUser = fetchUserDetails(id);
                  });
                },
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                child: Text("Fetch User", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              FutureBuilder(
                future: _fetchUser,
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: Colors.grey);
                  } else if (snapShot.hasError) {
                    return Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                    );
                  } else if (snapShot.hasData) {
                    final response = snapShot.data!;
                    return response.fold(
                      (e) => Text(
                        e.message,
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      (user) => UserDetailsCard(user: user),
                    );
                  }
                  return Text("Enter a user id and click button to get the user details");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
