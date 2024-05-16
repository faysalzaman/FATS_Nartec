import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/AssetVarification/SaveTag.dart';
import '../../constants.dart';
import '../../widgets/text_form_field_widget.dart';

class AssetTagInformationScreen extends StatefulWidget {
  String locationTag;
  String tagNumner;
  String assetLocationDetails;
  String serialNo;
  String employeeId;
  String phoneNo;
  String nameOwner;
  String otherTag;
  String notes;
  String assetCondition;
  String bought;
  String images;

  AssetTagInformationScreen({
    required this.locationTag,
    required this.tagNumner,
    required this.assetLocationDetails,
    required this.serialNo,
    required this.employeeId,
    required this.phoneNo,
    required this.nameOwner,
    required this.otherTag,
    required this.notes,
    required this.assetCondition,
    required this.bought,
    required this.images,
  });

  @override
  State<AssetTagInformationScreen> createState() =>
      _AssetTagInformationScreenState();
}

class _AssetTagInformationScreenState extends State<AssetTagInformationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _locationTagController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _assetLocationDetailsController =
      TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _phoneExtensionController =
      TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _otherTagController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _assetConditionController =
      TextEditingController();
  final TextEditingController _boughtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locationTagController.text = widget.locationTag;
    _tagController.text = widget.tagNumner;
    _assetLocationDetailsController.text = widget.assetLocationDetails;
    _serialNoController.text = widget.serialNo;
    _employeeIdController.text = widget.employeeId;
    _phoneExtensionController.text = widget.phoneNo;
    _employeeNameController.text = widget.nameOwner;
    _otherTagController.text = widget.otherTag;
    _notesController.text = widget.notes;
    _assetConditionController.text = widget.assetCondition;
    _boughtController.text = widget.bought;

    print(widget.images.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Tag Information'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Location Tag",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _locationTagController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        readOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Tag*",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormFieldWidget(
                          controller: _tagController,
                          height: 50,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Asset Location Details",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: _assetLocationDetailsController,
                          maxLines: 5,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Serial No",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        controller: _serialNoController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        readOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Employee Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Employee Name",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      TextFormFieldWidget(
                        controller: _employeeNameController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        readOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Employee Id
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Employee Id",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        readOnly: true,
                        controller: _employeeIdController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // phone extension
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Phone Extension",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _phoneExtensionController,
                        height: 50,
                        readOnly: true,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // other tag
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Other Tag",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      TextFormFieldWidget(
                        controller: _otherTagController,
                        height: 50,
                        readOnly: true,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // notes
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: _notesController,
                          maxLines: 3,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.images.split(',').map(
                        (e) {
                          return Card(
                            shadowColor: Constant.primaryColor,
                            elevation: 10,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: SizedBox(
                              height: 80,
                              width: 70,
                              child: Image.network(
                                "http://161.97.172.46:7001/${e.replaceAll("\\", '/')}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Text(
                                      "No Image",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Asset Condition",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _assetConditionController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        readOnly: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // bought
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Bought",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _boughtController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        readOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _locationTagController.dispose();
    _tagController.dispose();
    _assetLocationDetailsController.dispose();
    _serialNoController.dispose();
    _phoneExtensionController.dispose();
    _employeeIdController.dispose();
    _otherTagController.dispose();
    _notesController.dispose();
    _assetConditionController.dispose();
    _boughtController.dispose();
    _employeeNameController.dispose();
  }
}
