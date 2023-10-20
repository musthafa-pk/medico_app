import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicoapp/Util/routes/routes.dart';
import 'package:medicoapp/Util/util.dart';
import 'package:medicoapp/res/app_url.dart';

class FoodApp extends StatefulWidget {
  const FoodApp({Key? key}) : super(key: key);

  @override
  State<FoodApp> createState() => _FoodAppState();
}
class CustomDropdown extends StatelessWidget {
  final String hintText;
  final List<String> options;
  final Function(String)? onChanged;

  CustomDropdown({
    required this.hintText,
    required this.options,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: hintText,
      items: options.map((String status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(status),
        );
      }).toList(),
      onChanged: (v){
        Util.selected_Status = v;
      },
    );
  }
}

class _FoodAppState extends State<FoodApp> {
  List<Map<String, dynamic>> apiResponse = [];
  Map<int, bool> selectedRows = {};
  List<Map<String, dynamic>> selectedItems = [];
  bool multiselection = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse(AppUrl.getDetails),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"st_id": Util.userLogedID}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];
        apiResponse = List<Map<String, dynamic>>.from(responseData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void sendSelectedItems(List<Map<String, dynamic>> selectedItems) async {
    for (var selectedItem in selectedItems) {
      final Map<String, dynamic> requestBody = {
        "updatedata": selectedItems,
      };
      final response = await http.post(
        Uri.parse(AppUrl.changeStatus),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('selected dataaa${jsonEncode(selectedItem)}');

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, RoutesName.home1);
        Util.flushBarErrorMessage('Status changed successfully !', context);
        print('Selected item sent successfully');
      } else {
        Util.flushBarErrorMessage('Status changing failed !', context);
        print('Failed to send selected item');
      }
    }
  }

  Future<void> _refreshData() async {
    await fetchData();
  }
  void _changeStatus(List<Map<String, dynamic>> selectedItems) async {
    for (var selectedItem in selectedItems) {
      // Set the status based on the selected button
      selectedItem['status'] = Util.selected_Status;

      final Map<String, dynamic> requestBody = {
        "updatedata": [selectedItem],
      };

      final response = await http.post(
        Uri.parse(AppUrl.changeStatus),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, RoutesName.home1);
        Util.flushBarErrorMessage('Status changed successfully!', context);
        print('Selected item sent successfully');
      } else {
        Util.flushBarErrorMessage('Status changing failed!', context);
        print('Failed to send selected item');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Some error happened'));
              } else {
                return InkWell(
                  onLongPress: () {
                    setState(() {
                      multiselection = !multiselection;
                      print(multiselection);
                    });
                  },
                  child: Column(
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Stockist Name')),
                          DataColumn(label: Text('Logistic Name')),
                          DataColumn(label: Text('To')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Bill Number')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: getDataRows(),
                      ),
                      if (selectedItems.isNotEmpty) // Display buttons if items are selected
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle 'In Transit' button click
                                Util.selected_Status = 'In Transit';
                                _changeStatus(selectedItems);
                              },
                              child: Text('In Transit'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle 'Delivered' button click
                                Util.selected_Status = 'Delivered';
                                _changeStatus(selectedItems);
                              },
                              child: Text('Delivered'),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }



  List<DataRow> getDataRows() {
    return apiResponse.asMap().entries.map((entry) {
      final int index = entry.key;
      final Map<String, dynamic> data = entry.value;

      return DataRow(
        selected: multiselection && (selectedRows[index] ?? false),
        onSelectChanged: multiselection
            ? (selected) {
          if (selected != null) {
            setState(() {
              selectedRows[index] = selected;
              if (selected) {
                selectedItems.add({
                  "st_id": data["stockist_id"],
                  "id": data["id"],
                  "status": Util.selected_Status.toString(),
                });
              } else {
                selectedItems.removeWhere(
                      (item) =>
                  item["id"] == data["id"] &&
                      item["st_id"] == data["stockist_id"] &&
                      item['status'] == Util.selected_Status.toString(),
                );
              }
            });
          }
        }
            : null,
        cells: [
          DataCell(SelectableText(data['id'].toString())),
          DataCell(SelectableText(data['stockist_name'])),
          DataCell(SelectableText(data['logistic_name'])),
          DataCell(InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.filteredPage);
            },
            child: SelectableText(data['to']),
          )),
          DataCell(SelectableText(data['amount'].toString())),
          DataCell(SelectableText(data['bill_num'])),
          DataCell(SelectableText(data['status'].toString())),
        ],
      );

    }).toList();
  }
}

