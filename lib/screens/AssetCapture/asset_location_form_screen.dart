// ignore_for_file: non_constant_identifier_names

import 'package:fats_client/Services/GetAllCities/GetAllCitiesService.dart';
import 'package:fats_client/Services/GetArea/getAreaServices.dart';
import 'package:fats_client/constants.dart';
import 'package:fats_client/screens/AssetCapture/send_barcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/GetDepartment/getDepartment.dart';
import '../../widgets/text_form_field_widget.dart';
import '../../Services/Login/LoginServices.dart';
import '../../widgets/button_widget.dart';

class AssetLocationFormScreen extends StatefulWidget {
  const AssetLocationFormScreen({super.key});

  @override
  State<AssetLocationFormScreen> createState() =>
      _AssetLocationFormScreenState();
}

class _AssetLocationFormScreenState extends State<AssetLocationFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String regionCode = "";
  String area = "";

  String selectFloorNo = "";
  List<String> floorNoList = [];

  String selectCountry = "";
  List<String> countryList = [];

  String selectCity = "";
  List<String> cityList = [];

  String departmentName = "";
  List<String> departmentList = [];

  String businessUnit = "";
  List<String> businessUnitList = [];

  String branchCode = "";
  List<String> branchCodeList = [];

  List countryIdList = [];
  String countryId = "";

  TextEditingController areaController = TextEditingController();
  TextEditingController departmentCodeController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController buildingAddressController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();

  // Add FocusNodes
  final FocusNode _areaFocus = FocusNode();
  final FocusNode _departmentCodeFocus = FocusNode();
  final FocusNode _businessNameFocus = FocusNode();
  final FocusNode _buildingNameFocus = FocusNode();
  final FocusNode _buildingAddressFocus = FocusNode();
  final FocusNode _buildingNoFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Constant.showLoadingDialog(context);

      var value = await LoginServices.countriesList();
      setState(() {
        countryList = [];
        countryIdList = [];
        for (var i = 0; i < value.length; i++) {
          // Safely handle null values
          final countryName = value[i].countryName;
          final countryId = value[i].tblCountryID;
          if (countryName != null &&
              countryName.isNotEmpty &&
              countryId != null) {
            countryList.add(countryName);
            countryIdList.add(countryId.toString());
          }
        }
        // Only set selectCountry if list is not empty
        if (countryList.isNotEmpty) {
          Set<String> countrySet = countryList.toSet();
          countryList = countrySet.toList();
          selectCountry = countryList[0];
        }
      });

      // Only proceed if we have valid country IDs
      if (countryIdList.isNotEmpty) {
        countryId = countryIdList[0]; // Changed from index 1 to 0 for safety
        var city = await GetAllCitiesService.getCityById(countryId);

        setState(() {
          cityList = [];
          for (var i = 0; i < city.length; i++) {
            final cityName = city[i].cityName;
            if (cityName != null && cityName.isNotEmpty) {
              cityList.add(cityName);
            }
          }
          if (cityList.isNotEmpty) {
            Set<String> citySet = cityList.toSet();
            cityList = citySet.toList();
            selectCity = cityList[0];
          }
        });
      }
      Navigator.of(context).pop();

      var department = await GetAllDepartmentsService.getAllDepartments();

      setState(() {
        // Handle departments - add business group if daoName is null
        departmentList = [];
        for (var i = 0; i < department.length; i++) {
          final daoName = department[i].daoName;
          final businessGroup = department[i].bUSINESSGROUP;

          if ((daoName != null && daoName.trim().isNotEmpty) ||
              (businessGroup != null && businessGroup.trim().isNotEmpty)) {
            // Use daoName if available, otherwise use BUSINESSGROUP
            String departmentValue =
                (daoName != null && daoName.trim().isNotEmpty)
                    ? daoName.trim()
                    : businessGroup!.trim();
            departmentList.add(departmentValue);
          }
        }
        // Only set default if list is not empty
        departmentName = departmentList.isNotEmpty ? departmentList[0] : "";

        // Handle floor numbers - only add non-null and non-empty values
        floorNoList = [];
        for (var i = 0; i < department.length; i++) {
          final floorNum = department[i].dAONumber;
          if (floorNum != null && floorNum.trim().isNotEmpty) {
            floorNoList.add(floorNum.trim());
          }
        }
        selectFloorNo = floorNoList.isNotEmpty ? floorNoList[0] : "";

        // Handle business units - only add non-null and non-empty values
        businessUnitList = [];
        for (var i = 0; i < department.length; i++) {
          final busUnit = department[i].businessUnit;
          if (busUnit != null && busUnit.trim().isNotEmpty) {
            businessUnitList.add(busUnit.trim());
          }
        }
        businessUnit = businessUnitList.isNotEmpty ? businessUnitList[0] : "";

        // Handle branch codes - only add non-null and non-empty values
        branchCodeList = [];
        for (var i = 0; i < department.length; i++) {
          final branchCode = department[i].branchcode;
          if (branchCode != null && branchCode.trim().isNotEmpty) {
            branchCodeList.add(branchCode.trim());
          }
        }

        // Set initial values for controllers if data exists
        if (businessUnitList.isNotEmpty && branchCodeList.isNotEmpty) {
          businessNameController.text = businessUnitList[0];
          departmentCodeController.text = branchCodeList[0];
        }
      });

      // Handle area
      if (regionCode.isNotEmpty) {
        var area = await GetAreaServices.getArea(regionCode);
        setState(() {
          areaController.text = area;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose FocusNodes
    _areaFocus.dispose();
    _departmentCodeFocus.dispose();
    _businessNameFocus.dispose();
    _buildingNameFocus.dispose();
    _buildingAddressFocus.dispose();
    _buildingNoFocus.dispose();

    // Existing dispose calls
    areaController.dispose();
    departmentCodeController.dispose();
    businessNameController.dispose();
    buildingNameController.dispose();
    buildingAddressController.dispose();
    buildingNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Asset Location Form",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constant.primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Country ...............................................
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "COUNTRY",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: selectCountry,
                        isExpanded: true,
                        items: countryList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectCountry = value.toString();
                          int selectedIndex = countryList.indexOf(value!) - 1;
                          if (selectedIndex >= 0 &&
                              selectedIndex < countryIdList.length) {
                            countryId = countryIdList[selectedIndex];
                            GetAllCitiesService.getCityById(countryId)
                                .then((value) {
                              setState(() {
                                cityList = ["Select City"];
                                for (var i = 0; i < value.length; i++) {
                                  if (value[i].cityName != null &&
                                      value[i].cityName!.isNotEmpty) {
                                    cityList.add(value[i].cityName!);
                                  }
                                }
                                Set<String> citySet = cityList.toSet();
                                cityList = citySet.toList();
                                selectCity = cityList[0];
                              });
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Text(
                        "CITY",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: selectCity,
                        isExpanded: true,
                        items: cityList.map((value) {
                          // index = cityList.indexOf(value);
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectCity = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: regionCode == "" ? false : true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          "Area",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        width: MediaQuery.of(context).size.width * 1,
                        readOnly: true,
                        controller: areaController,
                        focusNode: _areaFocus,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_departmentCodeFocus);
                        },
                        height: 50,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Department ...............................................
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Text(
                        "Department",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: departmentName,
                        isExpanded: true,
                        items: departmentList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            departmentName = value.toString();
                            var index =
                                departmentList.indexOf(value.toString());

                            if (index >= 0) {
                              if (index < businessUnitList.length) {
                                businessNameController.text =
                                    businessUnitList[index];
                              }
                              if (index < branchCodeList.length) {
                                departmentCodeController.text =
                                    branchCodeList[index];
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Branch Code",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      readOnly: true,
                      controller: departmentCodeController,
                      focusNode: _departmentCodeFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_businessNameFocus);
                      },
                      hintText: 'Enter your branch code',
                      labelText: 'Branch Code',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Business Name",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      readOnly: true,
                      controller: businessNameController,
                      focusNode: _businessNameFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_buildingNameFocus);
                      },
                      hintText: 'Enter your business name',
                      labelText: 'Business Name',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Building Name",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      controller: buildingNameController,
                      focusNode: _buildingNameFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_buildingAddressFocus);
                      },
                      hintText: 'Enter your building name',
                      labelText: 'Building Name',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Building Address",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      controller: buildingAddressController,
                      focusNode: _buildingAddressFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_buildingNoFocus);
                      },
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Building No",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      width: MediaQuery.of(context).size.width * 1,
                      controller: buildingNoController,
                      focusNode: _buildingNoFocus,
                      onFieldSubmitted: (_) {
                        // This is the last field, so we can hide the keyboard
                        FocusScope.of(context).unfocus();
                      },
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: const Text(
                        "Floor No",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        value: selectFloorNo,
                        isExpanded: true,
                        items: floorNoList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectFloorNo = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        fontSize: 15,
                        color: Colors.grey,
                        title: "BACK",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ButtonWidget(
                        fontSize: 15,
                        color: Constant.primaryColor,
                        title: "NEXT",
                        onPressed: () {
                          Map<String, String> formData = {};

                          // Only add values that are not null and not empty
                          if (selectCountry.isNotEmpty) {
                            formData['country'] = selectCountry;
                          }
                          if (selectCity.isNotEmpty) {
                            formData['city'] = selectCity;
                          }
                          if (departmentName.isNotEmpty) {
                            formData['department'] = departmentName;
                          }
                          if (departmentCodeController.text.trim().isNotEmpty) {
                            formData['departmentCode'] =
                                departmentCodeController.text.trim();
                          }
                          if (businessNameController.text.trim().isNotEmpty) {
                            formData['businessName'] =
                                businessNameController.text.trim();
                          }
                          if (buildingNameController.text.trim().isNotEmpty) {
                            formData['buildingName'] =
                                buildingNameController.text.trim();
                          }
                          if (buildingAddressController.text
                              .trim()
                              .isNotEmpty) {
                            formData['buildingAddress'] =
                                buildingAddressController.text.trim();
                          }
                          if (buildingNoController.text.trim().isNotEmpty) {
                            formData['buildingNumber'] =
                                buildingNoController.text.trim();
                          }
                          if (selectFloorNo.isNotEmpty) {
                            formData['floorNumber'] = selectFloorNo;
                          }
                          if (areaController.text.trim().isNotEmpty) {
                            formData['region'] = areaController.text.trim();
                          }
                          if (businessUnit.isNotEmpty) {
                            formData['businessUnit'] = businessUnit;
                          }

                          // Check if we have at least one field filled
                          if (formData.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill at least one field"),
                              ),
                            );
                          } else {
                            Get.to(() => SendBarCodeScreen(
                                  country: formData['country'] ?? "",
                                  city: formData['city'] ?? "",
                                  department: formData['department'] ?? "",
                                  departmentCode:
                                      formData['departmentCode'] ?? "",
                                  businessName: formData['businessName'] ?? "",
                                  buildingName: formData['buildingName'] ?? "",
                                  buildingAddress:
                                      formData['buildingAddress'] ?? "",
                                  buildingNumber:
                                      formData['buildingNumber'] ?? "",
                                  floorNumber: formData['floorNumber'] ?? "",
                                  region: formData['region'] ?? "",
                                  businessUnit: formData['businessUnit'] ?? "",
                                ));
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
