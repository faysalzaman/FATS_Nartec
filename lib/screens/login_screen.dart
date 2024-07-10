import 'dart:convert';

import 'package:fats_client/widgets/fats_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_form_field_widget.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String languageValue = "English";
  var languageList = [
    "English",
    "Arabic",
  ];

  Future<void> _loginApi(String email, String password) async {
    print("base url is: ${Constant.baseUrl}");
    print("host is: ${Constant.host}");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String url = '${Constant.baseUrl}/login';
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': Constant.host,
    };

    final body = {"loginname": email, "loginpass": password};

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop();
        var data = jsonDecode(response.body);

        prefs.setString("token", "Bearer ${data['token']}");
        prefs.setString(
            "userName", jsonEncode(data['user'][0]['loginfullname']));
        prefs.setString("userEmail", jsonEncode(data['user'][0]['email']));
        prefs.setString(
            "userLoginId", jsonEncode(data['user'][0]['loginname']));

        Get.offAll(const HomeScreen());
        Get.snackbar(
          "Success",
          "Login Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        var body = jsonDecode(response.body);
        throw Exception(body['message']);
      }
    } catch (e) {
      Navigator.of(context).pop();

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background color
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const FatsWidget(),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login Name",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      controller: _emailController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: _passwordController,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Text(
                        "Select Language",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonFormField(
                        value: languageValue,
                        items: languageList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            languageValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  color: Constant.primaryColor,
                  title: "Login",
                  onPressed: () {
                    Constant.showLoadingDialog(context);
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      Navigator.of(context).pop();
                      Get.snackbar(
                        "Error",
                        "Please fill all the fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 3),
                      );
                    } else {
                      if (_formKey.currentState!.validate()) {
                        _loginApi(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.07,
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
