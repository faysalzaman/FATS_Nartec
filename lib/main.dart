import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fats',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
          secondary: Colors.deepPurple,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
