import 'package:fats_client/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo/app_icon.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const CircularProgressIndicator(
              color: Colors.blue,
              backgroundColor: Colors.white,
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
