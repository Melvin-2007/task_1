import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/ui/provider/user_details_prov.dart';
import 'package:task_1/ui/user_details_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
      ],
      child: const MaterialApp(home: UserDetailsScreen()),
    ),
  );
}
