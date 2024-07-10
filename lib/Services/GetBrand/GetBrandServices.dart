import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class GetBrandServices {
  static Future<List<String>> getBrandMethod(String sCode, String mCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    print("SCode : $sCode");
    print("MCode : $mCode");

    final String url = "${Constant.baseUrl}/getMakeListById";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
    };

    final body = {"TblMakeMainCode": sCode, "tblMajorCode": mCode};

    print("body: ${json.encode(body)}");

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print("Brand List Got Successfully");
        var data = json.decode(response.body);

        List<String> list = [];

        int length = data["recordset"].length;

        for (int i = 0; i < length; i++) {
          list = [...list, data["recordset"][i]["TblMakeName"]];
        }

        print("list: $list");

        return list;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);

      throw Exception('Failed to load data');
    }
  }
}
