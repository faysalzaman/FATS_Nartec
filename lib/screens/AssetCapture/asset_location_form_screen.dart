import 'package:fats_client/Services/GetAllCities/GetAllCitiesService.dart';
import 'package:fats_client/Services/GetArea/getAreaServices.dart';
import 'package:fats_client/constants.dart';
import 'package:fats_client/models/GetAllDepartmentsModel.dart';
import 'package:fats_client/screens/AssetCapture/send_barcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/GetDepartment/getDepartment.dart';
import '../../Services/Login/LoginServices.dart';
import '../../models/CountriesListModel.dart';
import '../../models/GetAllCitiesModel.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_form_field_widget.dart';

class AssetLocationFormScreen extends StatefulWidget {
  const AssetLocationFormScreen({super.key});

  @override
  State<AssetLocationFormScreen> createState() =>
      _AssetLocationFormScreenState();
}

class _AssetLocationFormScreenState extends State<AssetLocationFormScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String regionCode = "";
  String area = "";
  String departmentName = "";
  String BusinessUnit = "";

  String selectFloorNo = "Select Floor No";
  List<String> floorNoList = [
    "Select Floor No",
  ];

  String selectCountry = "Select Country";
  List<String> countryList = [
    "Select Country",
  ];

  String selectCity = "Select City";
  List<String> cityList = [
    "Select City",
  ];

  String selectRegion = "Select Department";
  List<String> regionList = [
    "Select Department",
  ];

  TextEditingController areaController = TextEditingController();
  TextEditingController departmentCodeController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController buildingAddressController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    areaController.dispose();
    departmentCodeController.dispose();
    businessNameController.dispose();
    buildingNameController.dispose();
    buildingAddressController.dispose();
    buildingNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asset Location Form",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FutureBuilder<List<CountriesListModel>>(
                    future: LoginServices.countriesList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Constant.showLoadingDialog(context);
                      }

                      if (snapshot.hasData) {
                        for (var i = 0; i < snapshot.data!.length; i++) {
                          countryList.add(snapshot.data![i].countryName!);
                        }

                        // convert the list to set to remove duplicate values
                        Set<String> countrySet = countryList.toSet();

                        // convert the set back to list
                        countryList = countrySet.toList();

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownButtonFormField(
                                value: selectCountry,
                                items: countryList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectCountry = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                const SizedBox(height: 10),
                FutureBuilder<List<GetAllCitiesModel>>(
                  future: GetAllCitiesService.getAllCities(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Constant.showLoadingDialog(context);
                    }

                    if (snapshot.hasData) {
                      for (var i = 0; i < snapshot.data!.length; i++) {
                        cityList.add(snapshot.data![i].cityName!);
                      }

                      // convert the list to set to remove duplicate values
                      Set<String> citySet = cityList.toSet();

                      // convert the set back to list
                      cityList = citySet.toList();

                      return Column(
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButtonFormField(
                              value: selectCity,
                              items: cityList.map((value) {
                                // index = cityList.indexOf(value);
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                int index = cityList.indexOf(value.toString());
                                setState(
                                  () {
                                    selectCity = value.toString();
                                    regionCode =
                                        snapshot.data![index].regionCode ?? "";
                                  },
                                );
                                print("regionCode: $regionCode");
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: regionCode == "" ? false : true,
                  child: FutureBuilder(
                      future: GetAreaServices.getArea(regionCode),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          Constant.showLoadingDialog(context);
                        }

                        if (snapshot.hasData) {
                          areaController.text = snapshot.data.toString();
                          print("Area : ${snapshot.data}");
                          return Column(
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
                                height: 50,
                              ),
                            ],
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<GetAllDepartmentsModel>>(
                    future: GetAllDepartmentsService.getAllDepartments(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Constant.showLoadingDialog(context);
                      }

                      if (snapshot.hasData) {
                        List<String> deppList = [];

                        for (var i = 0; i < snapshot.data!.length; i++) {
                          deppList.add(snapshot.data![i].daoName!);
                        }

                        String depName = deppList[0];

                        for (var i = 0; i < snapshot.data!.length; i++) {
                          floorNoList.add(snapshot.data![i].bUSINESSGROUP!);
                        }

                        // convert this list to set to remove duplicate values
                        Set<String> floorNoSet = floorNoList.toSet();

                        // convert set back to list
                        floorNoList = floorNoSet.toList();

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownButtonFormField(
                                value: depName,
                                items: deppList.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      departmentName = value.toString();
                                      businessNameController.text = snapshot
                                              .data![deppList
                                                  .indexOf(value.toString())]
                                              .businessUnit ??
                                          "";
                                      departmentCodeController.text = snapshot
                                              .data![deppList
                                                  .indexOf(value.toString())]
                                              .dAONumber ??
                                          "";
                                      BusinessUnit = snapshot
                                              .data![deppList
                                                  .indexOf(value.toString())]
                                              .businessUnit ??
                                          "";
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: const Text(
                        "Department Code",
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
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonFormField(
                        value: selectFloorNo,
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
                        color: Colors.deepPurple,
                        title: "NEXT",
                        onPressed: () {
                          if (selectCountry.isEmpty ||
                              selectCity.isEmpty ||
                              departmentCodeController.text.isEmpty ||
                              businessNameController.text.isEmpty ||
                              buildingNameController.text.isEmpty ||
                              buildingAddressController.text.isEmpty ||
                              buildingNoController.text.isEmpty ||
                              floorNoList.isEmpty ||
                              areaController.text.isEmpty ||
                              BusinessUnit.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please Fill All the above fields"),
                              ),
                            );
                          } else {
                            Get.to(() => SendBarCodeScreen(
                                  country: selectCountry.toString(),
                                  city: selectCity.toString(),
                                  department: departmentName.toString(),
                                  departmentCode:
                                      departmentCodeController.text.trim(),
                                  businessName:
                                      businessNameController.text.trim(),
                                  buildingName:
                                      buildingNameController.text.trim(),
                                  buildingAddress:
                                      buildingAddressController.text.trim(),
                                  buildingNumber:
                                      buildingNoController.text.trim(),
                                  floorNumber: selectFloorNo.toString(),
                                  region: areaController.text.trim(),
                                  businessUnit: BusinessUnit.toString(),
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
