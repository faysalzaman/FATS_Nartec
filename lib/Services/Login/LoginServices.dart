import 'package:fats_client/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../models/CountriesListModel.dart';

class LoginServices {
  static Future<List<CountriesListModel>> countriesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url = "${Constant.baseUrl}/GetAllCountry";

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
      "Host": Constant.host,
    };

    print(headers);

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        List<CountriesListModel> countriesList =
            data.map((e) => CountriesListModel.fromJson(e)).toList();
        return countriesList;
      } else {
        throw Exception('Failed to load countries list');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load countries list');
    }
  }
}
