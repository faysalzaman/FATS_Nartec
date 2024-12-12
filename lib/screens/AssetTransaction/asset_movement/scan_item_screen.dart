import 'package:fats_client/constants.dart';
import 'package:fats_client/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class ScanItemScreen extends StatefulWidget {
  @override
  _ScanItemScreenState createState() => _ScanItemScreenState();
}

class _ScanItemScreenState extends State<ScanItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromDaoNumberController = TextEditingController();
  final _toDaoNumberController = TextEditingController();
  final _tagNumberController = TextEditingController();
  final _totalAssetsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading icon color white
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Constant.primaryColor,
        title: const Text(
          'Scan Items',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From DAO Number',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A2472),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormFieldWidget(
                  controller: _fromDaoNumberController,
                  hintText: 'Enter / Scan DAO Number',
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 50,
                  color: Color.fromARGB(48, 45, 219, 146),
                ),
                SizedBox(height: 10.0),
                Text(
                  'To DAO Number',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A2472),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormFieldWidget(
                  controller: _toDaoNumberController,
                  hintText: 'Enter / Scan DAO Number',
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 50,
                  color: Color.fromARGB(48, 45, 219, 146),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Enter / Scan TAG Number',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A2472),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormFieldWidget(
                  controller: _tagNumberController,
                  hintText: 'Enter / Scan TAG Number',
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 50,
                  color: Color(0xFFFFF9C4),
                  suffix: Icon(Icons.qr_code),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0A2472),
                      width: 1.0,
                    ),
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color(0xFF0A2472).withOpacity(0.5);
                        }
                        return Color(0xFF0A2472);
                      },
                    ),
                    dataRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color.fromARGB(48, 45, 219, 146)
                              .withOpacity(0.5);
                        }
                        return Color.fromARGB(48, 45, 219, 146);
                      },
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          'Tag Number',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Transfer Date',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              '050000100100',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '26/03/2017',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total no. of assets',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A2472),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormFieldWidget(
                        controller: _totalAssetsController,
                        hintText: 'Enter Total Assets',
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: 50,
                        color: Color.fromARGB(48, 45, 219, 146),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Save button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Save'),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Add Another Item button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Add Another Item'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
