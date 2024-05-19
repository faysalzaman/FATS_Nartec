import 'package:fats_client/Services/AssetGenerate/GenerateTags.dart';
import 'package:fats_client/models/AssetGenerateModel.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      NewAssetTagGenerateServices.tagGenerate().then(
        (response) {
          setState(() {
            assetGenerateModel = response;
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
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: PaginatedDataTable(
                    header: const Text('Generated Asset Tags'),
                    headingRowColor:
                        MaterialStateProperty.all(Constant.primaryColor),
                    rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
                    columns: [
                      dataColumn('Id'),
                      dataColumn('Major Category'),
                      dataColumn('Major Category Description'),
                      dataColumn('Minor Category'),
                      dataColumn('Minor Category Description'),
                      dataColumn('Tag Number'),
                      dataColumn('Serial Number'),
                      dataColumn('Asset Description'),
                      dataColumn('Asset Type'),
                      dataColumn('Asset Condition'),
                      dataColumn('Manufacturer'),
                      dataColumn('Model Manufacturer'),
                      dataColumn('Region'),
                      dataColumn('Country'),
                      dataColumn('City'),
                      dataColumn('Department Code'),
                      dataColumn('Department Name'),
                      dataColumn('Business Unit'),
                      dataColumn('Building Number'),
                      dataColumn('Floor Number'),
                      dataColumn('Employee Id'),
                      dataColumn('PO Number'),
                      dataColumn('Delivery Note Number'),
                      dataColumn('Supplier'),
                      dataColumn('Invoice Number'),
                      dataColumn('Invoice Date'),
                      dataColumn('Ownership'),
                      dataColumn('Bought'),
                      dataColumn('Terminal Id'),
                      dataColumn('ATM Number'),
                      dataColumn('Location Tag'),
                      dataColumn('Building Name'),
                      dataColumn('Building Address'),
                      dataColumn('User Login Id'),
                      dataColumn('Main Sub Series'),
                      dataColumn(''),
                      dataColumn('Asset Date Captured'),
                      dataColumn('Asset Time Captured'),
                      dataColumn('Asset Date Scanned'),
                      dataColumn('Asset Time Scanned'),
                      dataColumn('Qty'),
                      dataColumn('Phone Exit Number'),
                      dataColumn('Full Location Details'),
                    ],
                    source: _DataSource(context, assetGenerateModel),
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

  _DataSource(this.context, this.assetGenerateModel);

  @override
  DataRow? getRow(int index) {
    final asset = assetGenerateModel[index];
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(asset.majorCategory ?? '')),
      DataCell(Text(asset.majorCategoryDescription ?? '')),
      DataCell(Text(asset.mInorCategory ?? '')),
      DataCell(Text(asset.minorCategoryDescription ?? '')),
      DataCell(Text(asset.tagNumber ?? '')),
      DataCell(Text(asset.sERIALnUMBER ?? '')),
      DataCell(Text(asset.aSSETdESCRIPTION ?? '')),
      DataCell(Text(asset.assettYPE ?? '')),
      DataCell(Text(asset.aSSETcONDITION ?? '')),
      DataCell(Text(asset.manufacturer ?? '')),
      DataCell(Text(asset.modelofAsset ?? '')),
      DataCell(Text(asset.rEGION ?? '')),
      DataCell(Text(asset.cOUNTRY ?? '')),
      DataCell(Text(asset.cityName ?? '')),
      DataCell(Text(asset.dao ?? '')),
      DataCell(Text(asset.daoName ?? '')),
      DataCell(Text(asset.businessUnit ?? '')),
      DataCell(Text(asset.bUILDINGNO ?? '')),
      DataCell(Text(asset.fLOORNO ?? '')),
      DataCell(Text(asset.eMPLOYEEID ?? '')),
      DataCell(Text(asset.ponUmber ?? '')),
      DataCell(Text(asset.deliveryNoteNo ?? '')),
      DataCell(Text(asset.supplier ?? '')),
      DataCell(Text(asset.invoiceNo ?? '')),
      DataCell(Text(asset.invoiceDate ?? '')),
      DataCell(Text(asset.ownership ?? '')),
      DataCell(Text(asset.bought ?? '')),
      DataCell(Text(asset.terminalID ?? '')),
      DataCell(Text(asset.aTMNumber ?? '')),
      DataCell(Text(asset.locationTag ?? '')),
      DataCell(Text(asset.buildingName ?? '')),
      DataCell(Text(asset.buildingAddress ?? '')),
      DataCell(Text(asset.userLoginID ?? '')),
      DataCell(Text(asset.mainSubSeriesNo?.toString() ?? '')),
      const DataCell(Text('')),
      DataCell(Text(asset.assetdatecaptured ?? '')),
      DataCell(Text(asset.assetTimeCaptured ?? '')),
      DataCell(Text(asset.assetdatescanned ?? '')),
      DataCell(Text(asset.assettimeScanned ?? '')),
      DataCell(Text(asset.qTY?.toString() ?? '')),
      DataCell(Text(asset.phoneExtNo ?? '')),
      DataCell(Text(asset.fullLocationDetails ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => assetGenerateModel.length;

  @override
  int get selectedRowCount => 0;
}
