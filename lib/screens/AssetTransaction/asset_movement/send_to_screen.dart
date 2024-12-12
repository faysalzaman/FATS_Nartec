// import 'dart:io';
import 'package:fats_client/constants.dart';
import 'package:fats_client/screens/AssetTransaction/asset_movement/scan_item_screen.dart';
import 'package:fats_client/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendToScreen extends StatefulWidget {
  const SendToScreen({super.key});

  @override
  State<SendToScreen> createState() => _SendToScreenState();
}

class _SendToScreenState extends State<SendToScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController areaController = TextEditingController();
  final TextEditingController daoNoController = TextEditingController();
  final TextEditingController businessAssetsController =
      TextEditingController();

  String? selectCity;
  var citiesList = [];

  String? selectFloor;
  var floorsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading icon color white
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Constant.primaryColor,
        title: const Text(
          'Send To',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Text(
                          "Send To",
                          style: TextStyle(
                            fontSize: 20,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        child: Text(
                          "City",
                          style: TextStyle(
                            fontSize: 15,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
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
                          hint: Text('Select a city'), // Add placeholder text
                          items: citiesList.map((value) {
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
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Text(
                          "Area",
                          style: TextStyle(
                            fontSize: 15,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: areaController,
                        height: 50,

                        hintText: 'Enter Area', // Add placeholder text
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),

                      SizedBox(height: 10),
                      // Landmark field
                      Text(
                        'DAO Number',
                        style: TextStyle(
                          fontSize: 15,
                          color: Constant.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller:
                            daoNoController, // Define this controller in your state
                        height: 50,
                        hintText: 'Select a Dao', // Add placeholder text
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),

                      SizedBox(height: 10),

                      // Address field
                      Text(
                        'Business',
                        style: TextStyle(
                          fontSize: 15,
                          color: Constant.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller:
                            businessAssetsController, // Define this controller in your state
                        height: 50,
                        hintText: 'Select Business', // Add placeholder text
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: Text(
                          "Floor Number",
                          style: TextStyle(
                            fontSize: 15,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField(
                          value: selectFloor,
                          isExpanded: true,
                          hint: Text("Select Floor Number"),
                          items: floorsList.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectFloor = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      Get.to(() => ScanItemScreen());
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    areaController.dispose();
    daoNoController.dispose();
    businessAssetsController.dispose();
  }
}
