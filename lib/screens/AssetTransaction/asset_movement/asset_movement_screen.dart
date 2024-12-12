// import 'dart:io';
import 'package:fats_client/constants.dart';
import 'package:fats_client/screens/AssetTransaction/asset_movement/pick_from_screen.dart';
import 'package:fats_client/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetMovementScreen extends StatefulWidget {
  const AssetMovementScreen({super.key});

  @override
  State<AssetMovementScreen> createState() => _AssetMovementScreenState();
}

class _AssetMovementScreenState extends State<AssetMovementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController trxNumnberController = TextEditingController();
  final TextEditingController requestController = TextEditingController();
  final TextEditingController totalAssetsController = TextEditingController();

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
          'Assets Inventory',
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
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Text(
                          "TRX Number",
                          style: TextStyle(
                            fontSize: 15,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        color: Colors.white,
                        controller: trxNumnberController,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: Text(
                          "Request",
                          style: TextStyle(
                            fontSize: 15,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(48, 45, 219, 146),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: requestController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: Text(
                          "Total  no. of assets",
                          style: TextStyle(
                            fontSize: 15,
                            color: Constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        color: Color.fromARGB(48, 45, 219, 146),
                        controller: trxNumnberController,
                        width: MediaQuery.of(context).size.width * 0.5,
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
                      Get.to(() => PickFromScreen());
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

    trxNumnberController.dispose();
    requestController.dispose();
    totalAssetsController.dispose();
  }
}
