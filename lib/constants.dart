import 'package:flutter/material.dart';

class Constant {
  static String baseUrl = 'http://161.97.172.46:7001/api';
  static String host = '161.97.172.46';

  static Future<dynamic> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ));
      },
    );
  }
}
