import 'package:dropdown_search/dropdown_search.dart';
import 'package:fats_client/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/AssetByCustodian/GetAllEmployeeByIdServices.dart';
import '../../Services/AssetByCustodian/GetAllEmployeesServices.dart';
import '../../Services/AssetByCustodian/GetEmpListById.dart';
import '../../constants.dart';
import '../../models/GetAllEmployeeListByIdModel.dart';
import '../../models/GetAllEmployeesModel.dart';
import '../../widgets/text_form_field_widget.dart';
import 'AssetDetailsById.dart';

class AssetByCustodian extends StatefulWidget {
  const AssetByCustodian({super.key});

  @override
  State<AssetByCustodian> createState() => _AssetByCustodianState();
}

class _AssetByCustodianState extends State<AssetByCustodian> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _employeeIdController = TextEditingController();
  TextEditingController _employeeNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _employeeIdController.dispose();
    _employeeNameController.dispose();
  }

  // List<AssetForPrintingModel> assetGenerateModel = [];

  List<GetAllEmployeeListByIdModel> getAllEmployeeByIdList = [];
  List<bool> isMarked = [];

  List<GetAllEmployeesModel> getAllEmployeesList = [];
  @override
  void initState() {
    super.initState();
    GetAllEmployeesServices.getAllEmployees().then((value) {
      getAllEmployeesList = value;
      isMarked = List<bool>.filled(getAllEmployeesList.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset By Custodian'),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items:
                              getAllEmployeesList.map((e) => e.empID!).toList(),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle: TextStyle(fontSize: 15),
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Employee Id",
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          enabled: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          selectedItem: "Select Employee Id",
                        ),
                        const SizedBox(height: 10),

                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: getAllEmployeesList
                              .map((e) => e.empName!)
                              .toList(),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            baseStyle: TextStyle(fontSize: 15),
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Employee Name",
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          enabled: true,
                          onChanged: (value) {
                            setState(() {
                              _employeeNameController.text = value!;
                            });
                          },
                          selectedItem: "Select Employee Name",
                        ),
                        // Autocomplete<GetAllEmployeesModel>(
                        //     optionsBuilder:
                        //         (TextEditingValue textEditingValue) {
                        //       if (textEditingValue.text == '') {
                        //         return const Iterable<
                        //             GetAllEmployeesModel>.empty();
                        //       }
                        //       return getAllEmployeesList.where((element) =>
                        //           element.empName!.toLowerCase().contains(
                        //               textEditingValue.text.toLowerCase()));
                        //     },
                        //     displayStringForOption: (option) {
                        //       return option.empName!;
                        //     },
                        //     initialValue: null,
                        //     optionsViewBuilder: (context, onSelected, options) {
                        //       return Align(
                        //         alignment: Alignment.topLeft,
                        //         child: Material(
                        //           elevation: 4.0,
                        //           child: Container(
                        //             height: 200,
                        //             width:
                        //                 MediaQuery.of(context).size.width * 0.9,
                        //             child: ListView.builder(
                        //               padding: const EdgeInsets.all(8.0),
                        //               itemCount: options.length,
                        //               itemBuilder:
                        //                   (BuildContext context, int index) {
                        //                 final option = options.elementAt(index);
                        //                 return GestureDetector(
                        //                   onTap: () {
                        //                     onSelected(option);
                        //                   },
                        //                   child: ListTile(
                        //                     title: Text(option.empName!),
                        //                   ),
                        //                 );
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     onSelected: (String) async {
                        //       _employeeIdController.text = getAllEmployeesList
                        //           .where((element) => element.empName == String)
                        //           .first
                        //           .empID
                        //           .toString();
                        //       Constant.showLoadingDialog(context);
                        //       GetEmployeeListByIdServices.GetEmpListByID(
                        //         _employeeIdController.text.trim().toString(),
                        //       ).then((value) {
                        //         _employeeNameController.text =
                        //             value.recordset?[0].empName ?? '';
                        //         GetAllEmployeeByIdServices.getAllEmployeeList(
                        //                 _employeeIdController.text
                        //                     .trim()
                        //                     .toString())
                        //             .then((value) {
                        //           getAllEmployeeByIdList = value;

                        //           for (int i = 0;
                        //               i < getAllEmployeeByIdList.length;
                        //               i++) {
                        //             isMarked.add(false);
                        //           }

                        //           setState(() {});

                        //           print(getAllEmployeeByIdList.length);

                        //           Navigator.pop(context);
                        //         }).onError((error, stackTrace) {
                        //           Navigator.of(context).pop();

                        //           ScaffoldMessenger.of(context)
                        //               .showSnackBar(SnackBar(
                        //             content: Text(error.toString()),
                        //           ));
                        //         });
                        //       }).onError((error, stackTrace) {
                        //         Navigator.of(context).pop();
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //           content: Text(error.toString()),
                        //         ));
                        //       });
                        //     }),
                        const SizedBox(height: 10),
                        const SizedBox(
                          child: Text(
                            "Employee ID",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: _employeeIdController,
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.9,
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                  Constant.showLoadingDialog(context);
                                  GetEmployeeListByIdServices.GetEmpListByID(
                                          _employeeIdController.text
                                              .trim()
                                              .toString())
                                      .then((value) {
                                    _employeeNameController.text =
                                        value.recordset?[0].empName ?? '';
                                    GetAllEmployeeByIdServices
                                            .getAllEmployeeList(
                                                _employeeIdController.text
                                                    .trim()
                                                    .toString())
                                        .then((value) {
                                      getAllEmployeeByIdList = value;

                                      for (int i = 0;
                                          i < getAllEmployeeByIdList.length;
                                          i++) {
                                        isMarked.add(false);
                                      }

                                      setState(() {});

                                      print(getAllEmployeeByIdList.length);

                                      Navigator.pop(context);
                                    }).onError((error, stackTrace) {
                                      Navigator.of(context).pop();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(error.toString()),
                                      ));
                                    });
                                  }).onError((error, stackTrace) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(error.toString()),
                                    ));
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Constant.showLoadingDialog(context);
                                GetEmployeeListByIdServices.GetEmpListByID(
                                        _employeeIdController.text
                                            .trim()
                                            .toString())
                                    .then((value) {
                                  _employeeNameController.text =
                                      value.recordset?[0].empName ?? '';
                                  GetAllEmployeeByIdServices.getAllEmployeeList(
                                          _employeeIdController.text
                                              .trim()
                                              .toString())
                                      .then((value) {
                                    getAllEmployeeByIdList = value;

                                    for (int i = 0;
                                        i < getAllEmployeeByIdList.length;
                                        i++) {
                                      isMarked.add(false);
                                    }

                                    setState(() {});

                                    print(getAllEmployeeByIdList.length);

                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) {
                                    Navigator.of(context).pop();

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(error.toString()),
                                    ));
                                  });
                                }).onError((error, stackTrace) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(error.toString()),
                                  ));
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(Icons.search),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        readOnly: true,
                        controller: _employeeNameController,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Asset Location Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 3,
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dataRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.withOpacity(0.2)),
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.deepPurple),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Select',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text(
                              'Asset Description',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                            DataColumn(
                                label: Text('Serial No.',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text('Tags No.',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text(
                              'Minor Description',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                          ],
                          rows: getAllEmployeeByIdList
                              .map(
                                (e) => DataRow(
                                  cells: [
                                    DataCell(
                                      Checkbox(
                                        value: isMarked[
                                            getAllEmployeeByIdList.indexOf(e)],
                                        onChanged: (value) {
                                          setState(() {
                                            // can select only one checkbox at a time
                                            for (int i = 0;
                                                i < isMarked.length;
                                                i++) {
                                              isMarked[i] = false;
                                            }
                                            isMarked[getAllEmployeeByIdList
                                                .indexOf(e)] = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.aSSETdESCRIPTION ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.sERIALnUMBER ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.tagNumber ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.minorCategoryDescription ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  !isMarked.contains(true)
                      ? Container()
                      : ButtonWidget(
                          title: "Click here for more information",
                          onPressed: () {
                            Get.to(AssetTagInformationScreen(
                              locationTag:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .locationTag ??
                                      '',
                              tagNumner:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .tagNumber ??
                                      '',
                              assetLocationDetails:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .fullLocationDetails ??
                                      '',
                              serialNo:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .sERIALnUMBER ??
                                      '',
                              employeeId:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .eMPLOYEEID ??
                                      '',
                              phoneNo:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .phoneExtNo ??
                                      '',
                              nameOwner: _employeeNameController.text.trim(),
                              otherTag:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .aTMNumber ??
                                      '',
                              notes:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .deliveryNoteNo ??
                                      '',
                              assetCondition:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .aSSETcONDITION ??
                                      '',
                              bought:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .bought ??
                                      '',
                              images:
                                  getAllEmployeeByIdList[isMarked.indexOf(true)]
                                          .images ??
                                      '',
                            ));
                          },
                          color: Colors.grey,
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.9,
                          fontSize: 15,
                        ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Text(
                          "Total Assets",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              getAllEmployeeByIdList.length.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    title: "Back",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.deepPurple,
                    height: 40,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
