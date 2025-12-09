import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/enums/user_fetch_state.dart';
import 'package:task_1/ui/provider/user_details_prov.dart';
import 'package:task_1/ui/widgets/user_details_card.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  static late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    Provider.of<UserDetailsProvider>(context, listen: false).clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textEditingController,
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
                onPressed: () => context.read<UserDetailsProvider>().fetchUser(textEditingController.text.trim()),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    context.watch<UserDetailsProvider>().userFetchState == UserFetchState.loading
                        ? Colors.grey
                        : Colors.blue,
                  ),
                ),
                child: Text("Fetch User", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Consumer<UserDetailsProvider>(
                builder: (context, prov, child) {
                  // shows loading indicator when userFetchState is loading
                  if (prov.userFetchState == UserFetchState.loading) {
                    return CircularProgressIndicator(color: Colors.deepPurple);
                  }
                  // shows user details card when userFetchState is success
                  else if (prov.userFetchState == UserFetchState.success) {
                    return UserDetailsCard(user: prov.user!);
                  }
                  // shows error message when userFetchState is error
                  else if (prov.userFetchState == UserFetchState.error) {
                    return Text(
                      prov.errorMessage,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                    );
                  }
                  // shows default message when userFetchState is initial
                  return Text(
                    "Enter a user id and click button to get the user details",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
