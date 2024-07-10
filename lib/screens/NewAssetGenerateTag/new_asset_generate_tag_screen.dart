import 'package:fats_client/Services/AssetGenerate/GenerateTags.dart';
import 'package:fats_client/models/AssetGenerateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Services/AssetGenerate/NewAssetTagGenerateServices.dart';
import '../../constants.dart';

class NewAssetGenerateTagScreen extends StatefulWidget {
  const NewAssetGenerateTagScreen({Key? key}) : super(key: key);

  @override
  State<NewAssetGenerateTagScreen> createState() =>
      _NewAssetGenerateTagScreenState();
}

class _NewAssetGenerateTagScreenState extends State<NewAssetGenerateTagScreen> {
  List<AssetGenerateModel> assetGenerateModel = [];
  List<bool> isMarked = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Future.delayed(const Duration(seconds: 3), () {
      NewAssetTagGenerateServices.tagGenerate().then(
        (response) {
          setState(() {
            assetGenerateModel = response;
            isMarked =
                List.generate(assetGenerateModel.length, (index) => false);
          });
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
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Constant.showLoadingDialog(context);
          GenerateTagsServices.tagGenerate(context);
        },
        label: const Text('Generate Tags'),
      ),
      body: assetGenerateModel.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      PaginatedDataTable(
                        header: const Text('Generated Asset Tags'),
                        headingRowColor:
                            MaterialStateProperty.all(Constant.primaryColor),
                        rowsPerPage: rowsPerPage,
                        onRowsPerPageChanged: (value) {
                          setState(() {
                            rowsPerPage =
                                value ?? PaginatedDataTable.defaultRowsPerPage;
                          });
                        },
                        columns: [
                          DataColumn(label: const Text('Mark')),
                          DataColumn(label: const Text('Id')),
                          DataColumn(label: const Text('Major Category')),
                          DataColumn(
                              label: const Text('Major Category Description')),
                          DataColumn(label: const Text('Minor Category')),
                          DataColumn(
                              label: const Text('Minor Category Description')),
                          DataColumn(label: const Text('Tag Number')),
                          DataColumn(label: const Text('Serial Number')),
                          DataColumn(label: const Text('Asset Description')),
                          DataColumn(label: const Text('Asset Type')),
                          DataColumn(label: const Text('Asset Condition')),
                          DataColumn(label: const Text('Manufacturer')),
                          DataColumn(label: const Text('Model Manufacturer')),
                          DataColumn(label: const Text('Region')),
                          DataColumn(label: const Text('Country')),
                          DataColumn(label: const Text('City')),
                          DataColumn(label: const Text('Department Code')),
                          DataColumn(label: const Text('Department Name')),
                          DataColumn(label: const Text('Business Unit')),
                          DataColumn(label: const Text('Building Number')),
                          DataColumn(label: const Text('Floor Number')),
                          DataColumn(label: const Text('Employee Id')),
                          DataColumn(label: const Text('PO Number')),
                          DataColumn(label: const Text('Delivery Note Number')),
                          DataColumn(label: const Text('Supplier')),
                          DataColumn(label: const Text('Invoice Number')),
                          DataColumn(label: const Text('Invoice Date')),
                          DataColumn(label: const Text('Ownership')),
                          DataColumn(label: const Text('Bought')),
                          DataColumn(label: const Text('Terminal Id')),
                          DataColumn(label: const Text('ATM Number')),
                          DataColumn(label: const Text('Location Tag')),
                          DataColumn(label: const Text('Building Name')),
                          DataColumn(label: const Text('Building Address')),
                          DataColumn(label: const Text('User Login Id')),
                          DataColumn(label: const Text('Main Sub Series')),
                          DataColumn(label: const Text('')),
                          DataColumn(label: const Text('Asset Date Captured')),
                          DataColumn(label: const Text('Asset Time Captured')),
                          DataColumn(label: const Text('Asset Date Scanned')),
                          DataColumn(label: const Text('Asset Time Scanned')),
                          DataColumn(label: const Text('Qty')),
                          DataColumn(label: const Text('Phone Exit Number')),
                          DataColumn(
                              label: const Text('Full Location Details')),
                        ],
                        source: _DataSource(
                          context: context,
                          assetGenerateModel: assetGenerateModel,
                          isMarked: isMarked,
                          setState: setState,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      List<String> selectedAssets = [];
                      for (int i = 0; i < isMarked.length; i++) {
                        if (isMarked[i]) {
                          selectedAssets
                              .add(assetGenerateModel[i].tagNumber ?? '');
                        }
                      }
                      if (selectedAssets.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select at least one asset'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Handle print functionality
                      }
                    },
                    child: const Text('Print Asset'),
                  ),
                ),
              ],
            ),
    );
  }

  DataColumn dataColumn(String label) {
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

class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<AssetGenerateModel> assetGenerateModel;
  final List<bool> isMarked;
  final void Function(VoidCallback fn) setState;

  _DataSource({
    required this.context,
    required this.assetGenerateModel,
    required this.isMarked,
    required this.setState,
  });

  @override
  DataRow getRow(int index) {
    final asset = assetGenerateModel[index];
    return DataRow(
      cells: [
        DataCell(
          Checkbox(
            value: isMarked[index],
            onChanged: (value) {
              setState(() {
                isMarked[index] = value!;
              });
            },
          ),
        ),
        DataCell(Text((index + 1).toString())),
        DataCell(Text(asset.majorCategory ?? '')),
        DataCell(Text(asset.majorCategoryDescription ?? '')),
        DataCell(Text(asset.mInorCategory ?? '')),
        DataCell(Text(asset.minorCategoryDescription ?? '')),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(asset.tagNumber ?? ""),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: asset.tagNumber ?? ""));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tag Number Copied to Clipboard'),
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
        DataCell(Text(asset.mainSubSeriesNo?.toString() ?? "")),
        const DataCell(Text("")),
        DataCell(Text(asset.assetdatecaptured ?? "")),
        DataCell(Text(asset.assetTimeCaptured ?? "")),
        DataCell(Text(asset.assetdatescanned ?? "")),
        DataCell(Text(asset.assettimeScanned ?? "")),
        DataCell(Text(asset.qTY?.toString() ?? "")),
        DataCell(Text(asset.phoneExtNo ?? "")),
        DataCell(Text(asset.fullLocationDetails ?? "")),
      ],
    );
  }

  @override
  int get rowCount => assetGenerateModel.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => isMarked.where((marked) => marked).length;
}
