// ignore_for_file: deprecated_member_use

import 'package:fats_client/Services/AssetForPrinting/AssetForPrintingServices.dart';

import 'package:fats_client/Services/AssetVarification/DeleteTag.dart';
import 'package:fats_client/screens/AssetForPrinting/BarcodeLabelScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/AssetForPrintingModel.dart';

class AssetForPrintingScreen extends StatefulWidget {
  const AssetForPrintingScreen({super.key});

  @override
  State<AssetForPrintingScreen> createState() => _AssetForPrintingScreenState();
}

class _AssetForPrintingScreenState extends State<AssetForPrintingScreen> {
  List<AssetForPrintingModel> assetGenerateModel = [];
  List<bool> isMarked = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        AssetForPrintingServices.assetForPrint().then(
          (response) {
            assetGenerateModel = response;
            for (int i = 0; i < assetGenerateModel.length; i++) {
              isMarked.add(false);
            }
            setState(() {});
          },
        ).onError(
          (error, stackTrace) {
            Navigator.pop(context);
            print("Error is: $error");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printing Assets'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          List<String> _tagNumber = [];
          List<String> _assetDescription = [];
          List<String> _barcodeInfo = [];

          for (int i = 0; i < isMarked.length; i++) {
            if (isMarked[i]) {
              _tagNumber.add(assetGenerateModel[i].tagNumber!);
              _assetDescription.add(assetGenerateModel[i].aSSETdESCRIPTION!);
              _barcodeInfo.add(assetGenerateModel[i].tagNumber! +
                  " " +
                  assetGenerateModel[i].minorCategoryDescription!);
            }
          }

          if (_tagNumber.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select at least one asset'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            Get.to(() => BarcodeLabelScreen(
                  tagNumber: _tagNumber,
                  assetDescription: _assetDescription,
                  qrCode: _barcodeInfo,
                ));
          }
        },
        label: const Text('Print Asset'),
      ),
      body: assetGenerateModel.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    border: TableBorder.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Constant.primaryColor,
                    ),
                    columnSpacing: 30,
                    dataRowHeight: 50,
                    columns: [
                      DataColumWidget("Mark"),
                      DataColumWidget("Id"),
                      DataColumWidget("Major Category"),
                      DataColumWidget("Major Category Description"),
                      DataColumWidget("Minor Category"),
                      DataColumWidget("Minor Category Description"),
                      DataColumWidget("Tag Number"),
                      DataColumWidget("Serial Number"),
                      DataColumWidget("Asset Description"),
                      DataColumWidget("Asset Type"),
                      DataColumWidget("Asset Condition"),
                      DataColumWidget("Manufacturer"),
                      DataColumWidget("Model Manufacturer"),
                      DataColumWidget("Region"),
                      DataColumWidget("Country"),
                      DataColumWidget("City"),
                      DataColumWidget("Department Code"),
                      DataColumWidget("Department Name"),
                      DataColumWidget("Business Unit"),
                      DataColumWidget("Building Number"),
                      DataColumWidget("Floor Number"),
                      DataColumWidget("Employee Id"),
                      DataColumWidget("PO Number"),
                      DataColumWidget("Delivery Note Number"),
                      DataColumWidget("Supplier"),
                      DataColumWidget("Invoice Number"),
                      DataColumWidget("Invoice Date"),
                      DataColumWidget("Ownership"),
                      DataColumWidget("Bought"),
                      DataColumWidget("Terminal Id"),
                      DataColumWidget("ATM Number"),
                      DataColumWidget("Location Tag"),
                      DataColumWidget("Building Name"),
                      DataColumWidget("Building Address"),
                      DataColumWidget("User Login Id"),
                      DataColumWidget("Main Sub Series"),
                      DataColumWidget("Major Categories Plus Miner Categories"),
                      DataColumWidget("Asset Date Captured"),
                      DataColumWidget("Asset Time Captured"),
                      DataColumWidget("Asset Date Scanned"),
                      DataColumWidget("Asset Time Scanned"),
                      DataColumWidget("Qty"),
                      DataColumWidget("Phone Exit Number"),
                      DataColumWidget("Full Location Details"),
                      DataColumWidget("Delete Asset"),
                    ],
                    rows: assetGenerateModel
                        .map(
                          (asset) => DataRow(
                            cells: [
                              DataCell(Checkbox(
                                value:
                                    isMarked[assetGenerateModel.indexOf(asset)],
                                onChanged: (value) {
                                  setState(() {
                                    isMarked[assetGenerateModel
                                        .indexOf(asset)] = value!;
                                  });
                                },
                              )),
                              DataCell(Text(
                                  (assetGenerateModel.indexOf(asset) + 1)
                                      .toString())),
                              DataCell(Text(asset.majorCategory ?? '')),
                              DataCell(Text(
                                  asset.majorCategoryDescription.toString())),
                              DataCell(Text(asset.mInorCategory.toString())),
                              DataCell(Text(
                                  asset.minorCategoryDescription.toString())),
                              DataCell(
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SelectableText(asset.tagNumber ?? ""),
                                    IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: asset.tagNumber ?? ""));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Tag Number Copied to Clipboard'),
                                            backgroundColor: Colors.black,
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(Text(asset.sERIALnUMBER ?? "")),
                              DataCell(Text(asset.aSSETdESCRIPTION ?? "")),
                              DataCell(Text(asset.assettYPE ?? "")),
                              DataCell(Text(asset.aSSETcONDITION ?? "")),
                              DataCell(Text(asset.manufacturer ?? "")),
                              DataCell(Text(asset.modelofAsset ?? "")),
                              DataCell(Text(asset.rEGION ?? "")),
                              DataCell(Text(asset.cOUNTRY ?? "")),
                              DataCell(Text(asset.cityName ?? "")),
                              DataCell(Text(asset.dao ?? "")),
                              DataCell(Text(asset.daoName ?? "")),
                              DataCell(Text(asset.businessUnit ?? "")),
                              DataCell(Text(asset.bUILDINGNO ?? "")),
                              DataCell(Text(asset.fLOORNO ?? "")),
                              DataCell(Text(asset.eMPLOYEEID ?? "")),
                              DataCell(Text(asset.ponUmber ?? "")),
                              DataCell(Text(asset.deliveryNoteNo ?? "")),
                              DataCell(Text(asset.supplier ?? "")),
                              DataCell(Text(asset.invoiceNo ?? "")),
                              DataCell(Text(asset.invoiceDate ?? "")),
                              DataCell(Text(asset.ownership ?? "")),
                              DataCell(Text(asset.bought ?? "")),
                              DataCell(Text(asset.terminalID ?? "")),
                              DataCell(Text(asset.aTMNumber ?? "")),
                              DataCell(Text(asset.locationTag ?? "")),
                              DataCell(Text(asset.buildingName ?? "")),
                              DataCell(Text(asset.buildingAddress ?? "")),
                              DataCell(Text(asset.userLoginID ?? "")),
                              DataCell(Text(
                                  asset.mainSubSeriesNo?.toString() ?? "")),
                              const DataCell(Text("")),
                              DataCell(Text(asset.assetdatecaptured ?? "")),
                              DataCell(Text(asset.assetTimeCaptured ?? "")),
                              DataCell(Text(asset.assetdatescanned ?? "")),
                              DataCell(Text(asset.assettimeScanned ?? "")),
                              DataCell(Text(asset.qTY?.toString() ?? "")),
                              DataCell(Text(asset.phoneExtNo ?? "")),
                              DataCell(Text(asset.fullLocationDetails ?? "")),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                            'Are you sure you want to delete this asset?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Constant.showLoadingDialog(
                                                  context);
                                              await DeleteTagServices.deleteTag(
                                                  asset.tagNumber ?? "");
                                              Navigator.pop(context);
                                              Navigator.pop(context);

                                              setState(() {
                                                assetGenerateModel.removeAt(
                                                    assetGenerateModel
                                                        .indexOf(asset));
                                              });
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
            ),
    );
  }

  DataColumn DataColumWidget(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    assetGenerateModel.clear();
    isMarked.clear();
  }
}
