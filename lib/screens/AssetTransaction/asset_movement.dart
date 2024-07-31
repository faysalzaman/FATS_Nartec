import 'package:fats_client/constants.dart';
import 'package:flutter/material.dart';

class AssetMovement extends StatefulWidget {
  const AssetMovement({super.key});

  @override
  State<AssetMovement> createState() => _AssetMovementState();
}

class _AssetMovementState extends State<AssetMovement> {
  int _rowsPerPage = 5; // Set default rows per page to 5
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Asset Movement',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text('Request #',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text('Tag #',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                // Paginated Table
                Row(
                  children: [
                    Expanded(
                      child: PaginatedDataTable(
                        showFirstLastButtons: true,
                        header: const Text(
                          'Asset Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        arrowHeadColor: Colors.black,
                        headingRowColor: MaterialStateProperty.all(
                          Constant.primaryColor,
                        ),
                        rowsPerPage: _rowsPerPage,
                        availableRowsPerPage: [
                          5
                        ], // Limit rows per page options to 5
                        onRowsPerPageChanged: (int? value) {
                          setState(() {
                            _rowsPerPage = value!;
                          });
                        },
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        onSelectAll: (bool? value) {},
                        columns: <DataColumn>[
                          DataColumn(
                            label: const Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            onSort: (int columnIndex, bool ascending) {
                              setState(() {
                                _sortColumnIndex = columnIndex;
                                _sortAscending = ascending;
                              });
                            },
                          ),
                          const DataColumn(
                            label: Text(
                              'Age',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        source: MyTableSource(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        "Transfer to\nlocation",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        "Total Assets",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Back"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Save & Confirm"),
                    )
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTableSource extends DataTableSource {
  // Sample data for demonstration
  final List<Map<String, dynamic>> _data = [
    {'name': 'John', 'age': 30},
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 40},
    // Add more data as needed
  ];

  @override
  DataRow getRow(int index) {
    final row = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row['name'])),
        DataCell(Text('${row['age']}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0; // You can implement selection if needed
}
