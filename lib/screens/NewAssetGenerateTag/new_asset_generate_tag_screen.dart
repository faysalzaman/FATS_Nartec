import 'package:fats_client/Services/AssetGenerate/GenerateTags.dart';
import 'package:fats_client/models/AssetGenerateModel.dart';
import 'package:flutter/material.dart';

import '../../Services/AssetGenerate/NewAssetTagGenerateServices.dart';
import '../../constants.dart';

class NewAssetGenerateTagScreen extends StatefulWidget {
  const NewAssetGenerateTagScreen({super.key});

  @override
  State<NewAssetGenerateTagScreen> createState() =>
      _NewAssetGenerateTagScreenState();
}

class _NewAssetGenerateTagScreenState extends State<NewAssetGenerateTagScreen> {
  List<AssetGenerateModel> assetGenerateModel = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      NewAssetTagGenerateServices.tagGenerate().then(
        (response) {
          assetGenerateModel = response;
          setState(() {});
        },
      ).onError((error, stackTrace) {
        Navigator.pop(context);
        print("Error is: $error");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate New Tags'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Constant.showLoadingDialog(context);
          GenerateTagsServices.tagGenerate(context);
        },
        label: const Text('Generate Tags'),
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
                    ],
                    rows: assetGenerateModel
                        .map(
                          (asset) => DataRow(
                            cells: [
                              DataCell(Text(
                                  (assetGenerateModel.indexOf(asset) + 1)
                                      .toString())),
                              DataCell(Text(asset.majorCategory ?? '')),
                              DataCell(
                                  Text(asset.majorCategoryDescription ?? "")),
                              DataCell(Text(asset.mInorCategory ?? "")),
                              DataCell(
                                  Text(asset.minorCategoryDescription ?? "")),
                              DataCell(Text(asset.tagNumber ?? "")),
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
}
