import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final String label;
  final String data;
  const UserInfoTile({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
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
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
