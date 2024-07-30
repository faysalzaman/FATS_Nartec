import 'dart:io';

import 'package:fats_client/Services/AssetVarification/DeleteTag.dart';
import 'package:fats_client/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SaveTagServices {
  static Future<void> saveTag(
    int tblAssetMasterEncodeAssetCaptureID,
    String majorCategory,
    String majorCategoryDescription,
    String minorCategory,
    String minorCategoryDescription,
    String tagNo,
    String serialNo,
    String assetDescription,
    String assetType,
    String assetCondition,
    String country,
    String region,
    String cityName,
    String dao,
    String daoName,
    String businessUnit,
    String buildingNo,
    String floorNo,
    String employeeID,
    String ponNumber,
    String poDate,
    String deliveryNoteNo,
    String supplier,
    String invoiceNo,
    String invoiceDate,
    String modelOfAsset,
    String manufacturer,
    String ownership,
    String bought,
    String terminalID,
    String atmNumber,
    String locationTag,
    String buildingName,
    String buildingAddress,
    int mainSubSeriesNo,
    String assetDateCaptured,
    String assetTimeCaptured,
    String assetDateScanned,
    String assetTimeScanned,
    int qty,
    String phoneExtNo,
    String fullLocationDetails,
    List<XFile> file,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String userLoginId = prefs.getString('userLoginId') ?? '';

    final String url =
        "${Constant.baseUrl}/PostAssetMasterEncodeAssetCaptureFinal";
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Content-Type": "multipart/form-data",
      "Host": Constant.host,
    };

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);

    request.fields['TblAssetMasterEncodeAssetCaptureID'] =
        tblAssetMasterEncodeAssetCaptureID.toString();
    request.fields['MajorCategory'] = majorCategory;
    request.fields['MajorCategoryDescription'] = majorCategoryDescription;
    request.fields['MInorCategory'] = minorCategory;
    request.fields['MinorCategoryDescription'] = minorCategoryDescription;
    request.fields['TagNumber'] = tagNo;
    request.fields['sERIALnUMBER'] = serialNo;
    request.fields['aSSETdESCRIPTION'] = assetDescription;
    request.fields['assettYPE'] = assetType;
    request.fields['aSSETcONDITION'] = assetCondition;
    request.fields['cOUNTRY'] = country;
    request.fields['rEGION'] = region;
    request.fields['CityName'] = cityName;
    request.fields['Dao'] = dao;
    request.fields['DaoName'] = daoName;
    request.fields['BusinessUnit'] = businessUnit;
    request.fields['BUILDINGNO'] = buildingNo;
    request.fields['FLOORNO'] = floorNo;
    request.fields['EMPLOYEEID'] = employeeID;
    request.fields['ponUmber'] = ponNumber;
    request.fields['Podate'] = poDate;
    request.fields['DeliveryNoteNo'] = deliveryNoteNo;
    request.fields['Supplier'] = supplier;
    request.fields['InvoiceNo'] = invoiceNo;
    request.fields['InvoiceDate'] = invoiceDate;
    request.fields['ModelofAsset'] = modelOfAsset;
    request.fields['Manufacturer'] = manufacturer;
    request.fields['Ownership'] = ownership;
    request.fields['Bought'] = bought;
    request.fields['TerminalID'] = terminalID;
    request.fields['ATMNumber'] = atmNumber;
    request.fields['LocationTag'] = locationTag;
    request.fields['buildingName'] = buildingName;
    request.fields['buildingAddress'] = buildingAddress;
    request.fields['UserLoginID'] = userLoginId;
    request.fields['MainSubSeriesNo'] = mainSubSeriesNo.toString();
    request.fields['assetdatecaptured'] = assetDateCaptured;
    request.fields['assetTimeCaptured'] = assetTimeCaptured;
    request.fields['assetdatescanned'] = assetDateScanned;
    request.fields['assettimeScanned'] = assetTimeScanned;
    request.fields['QTY'] = qty.toString();
    request.fields['PhoneExtNo'] = phoneExtNo;
    request.fields['FullLocationDetails'] = fullLocationDetails;

    List<File> fle = [];

    for (int i = 0; i < file.length; i++) {
      fle.add(File(file[i].path));
    }

    for (int i = 0; i < fle.length; i++) {
      var multipart = await http.MultipartFile.fromPath('images', fle[i].path);
      request.files.add(multipart);
    }

    // print request
    print(request);
    print(request.fields);
    print(request.files);

    try {
      request.send().then(
        (response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            print("Uploaded!");
            DeleteTagServices.deleteTag(tagNo);

            Get.offAll(const HomeScreen());
            Get.snackbar(
              "Success",
              "Tag Verified Successfully",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            print("Failed!");
          }
        },
      ).onError((error, stackTrace) {
        Get.back();
        Get.snackbar(
          "Error",
          "Failed to Save Data",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        throw Exception("Failed to load Data");
      });
    } catch (e) {
      print(e);
      throw Exception('Failed to load Data');
    }
  }
}
