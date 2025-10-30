import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final String title;
  final String description;
  const UserInfoTile({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 10),
        Text(":"),
        SizedBox(width: 10),
        Text(
          description,
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
