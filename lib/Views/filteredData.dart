import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicoapp/Util/util.dart';
import 'package:http/http.dart' as http;
import '../res/Components/custom_dropdown.dart';
import '../res/app_url.dart';

class FilteredDataPage extends StatefulWidget {
  const FilteredDataPage({Key? key}) : super(key: key);

  @override
  State<FilteredDataPage> createState() => _FilteredDataPageState();
}

class _FilteredDataPageState extends State<FilteredDataPage> {
  TextEditingController _otpController = TextEditingController();
  final _newformKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> selectedItems = [];
  bool selectAll = false;

  void toggleSelection(Map<String, dynamic> item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add({
          'st_id': item['st_id'],
          'id': item['id'],
          'status': item['status'],
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('${Util.selected_to.toString().toUpperCase()}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
              future: Util.filterdata(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Some Error Occured !'));
                } else {
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('Select')),
                      DataColumn(label: Text('Stockist')),
                      DataColumn(label: Text('To')),
                      DataColumn(label: Text('Amount')),
                      DataColumn(label: Text('Bill Num')),
                      DataColumn(label: Text('Status'))
                    ],
                    rows: Util.filtertableDataset[0]['data']
                        .where((data) =>
                    data['to'].toString() ==
                        Util.selected_to.toString())
                        .map<DataRow>((data) {
                      return buildDataRow(data);
                    }).toList(),
                    onSelectAll: (isSelectedAll) {},
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(Map<String, dynamic> data) {
    bool isSelected = selectedItems.contains(data) || selectAll;

    return DataRow(
      cells: [
        DataCell(
          Checkbox(
            value: isSelected,
            onChanged: (_) {
              toggleSelection(data);
            },
          ),
        ),
        DataCell(Text(data['stockist_name'].toString())),
        DataCell(Text(data['to'].toString())),
        DataCell(Text(data['amount'].toString())),
        DataCell(Text(data['bill_num'].toString())),
        DataCell(
          CustomDropdown(
            options: ['In Transit', 'Delivered'],
            hintText:
            data['status'] == null ? '-' : data['status'].toString(),
            onChanged: (value) {
              // ... (rest of your code remains the same)
            },
          ),
        ),
      ],
    );
  }
}
