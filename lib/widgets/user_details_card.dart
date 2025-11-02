import 'package:flutter/material.dart';
import 'package:task_1/models/user_model.dart';
import 'package:task_1/widgets/user_info_tile.dart';

class UserDetailsCard extends StatelessWidget {
  final User user;
  const UserDetailsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            user.profileImage ?? "",
            fit: BoxFit.fill,
            errorBuilder: (error, obj, stackTracer) => Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(color: Colors.lightGreen, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.error_outline, color: Colors.white),
            ),
            height: 300,
            width: 300,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              UserInfoTile(label: "Name", data: user.name!),
              UserInfoTile(label: "User ID", data: user.userId.toString()),
              UserInfoTile(label: "Age", data: user.age.toString()),
              UserInfoTile(label: "Profession", data: user.profession!),
            ],
          ),
        ),
      ],
    ),
  );
}
