import 'package:flutter/material.dart';
import 'package:task_1/enums/user_fetch_state.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/widgets/user_details_card.dart';

class UserDetailsCardBuilder extends StatelessWidget {
  final User? user;
  final UserFetchState userFetchState;
  final String errorMessage;
  const UserDetailsCardBuilder({
    super.key,
    required this.user,
    required this.userFetchState,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    switch (userFetchState) {
      case UserFetchState.initial:
        return Text("Enter a user id and click button to get the user details");
      case UserFetchState.loading:
        return CircularProgressIndicator(color: Colors.grey);
      case UserFetchState.success:
        return UserDetailsCard(user: user!);
      case UserFetchState.error:
        return Text(
          errorMessage,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        );
    }
  }
}
