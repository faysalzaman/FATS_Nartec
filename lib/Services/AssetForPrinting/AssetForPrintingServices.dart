import 'package:fats_client/models/AssetForPrintingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AssetForPrintingServices {
  static Future<List<AssetForPrintingModel>> assetForPrint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final String url =
        "${Constant.baseUrl}/GetAllAssetMasterEncodeAssetCapture";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("status code: ${response.statusCode}");
        var data = json.decode(response.body);
        List<AssetForPrintingModel> assetGenerateModel = (data as List)
            .map((e) => AssetForPrintingModel.fromJson(e))
            .toList();
        return assetGenerateModel;
      } else if (response.statusCode == 404) {
        throw Exception('Failed to load Data');
      } else {
        print("status code: ${response.statusCode}");
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load Data');
    }
  }
}
