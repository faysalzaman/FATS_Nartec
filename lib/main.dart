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
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FATS',
      // theme: ThemeData(
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   colorScheme:
      //       ColorScheme.fromSwatch(primarySwatch: Constant.primaryColor).copyWith(
      //     secondary: Constant.primaryColor,
      //   ),
      // ),
      home: LoginScreen(),
    );
  }
}
