import 'package:flutter/material.dart';

class Constant {
  // static String baseUrl = 'http://161.97.172.46:7001/api';

  // static String baseUrl = "http://gs1ksa.org:7001/api";

  // static String baseUrl = "https://mala.fatsme.online/api";

  static String baseUrl = "https://gtrack.online:7003/api";

  static String placeHolderImage =
      "https://www.kpriet.ac.in/asset/frontend/images/nodata.png";

  static Color primaryColor = const Color(0xFF00006A);

  static Future<dynamic> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF00006A),
            strokeWidth: 2,
          ),
        );
      },
    );
  }
}
