import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final String label;
  final String data;
  const UserInfoTile({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                ":",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            data,
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
