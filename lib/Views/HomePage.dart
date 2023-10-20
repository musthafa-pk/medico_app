//   import 'dart:convert';
//
//   import 'package:flutter/material.dart';
// import 'package:medicoapp/Util/routes/routes.dart';
//   import 'package:medicoapp/Util/util.dart';
//   import 'package:medicoapp/res/Components/custom_dropdown.dart';
//   import 'package:http/http.dart' as http;
//   import 'package:medicoapp/res/app_url.dart';
//   class HomePage extends StatefulWidget {
//     const HomePage({Key? key}) : super(key: key);
//
//     @override
//     State<HomePage> createState() => _HomePageState();
//   }
//
//   class _HomePageState extends State<HomePage> {
//
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//     final TextEditingController _otpController = TextEditingController();
//
//     int rowNumber = 1;
//
//     bool selectAll = false;
//
//     List<Map<String,dynamic>> selectedItems = [];
//
//     void toggleSelection(Map<String,dynamic>item){
//       print('selected items${selectedItems}');
//       print(selectedItems[0]['stockist_id']);
//       setState(() {
//         if(selectedItems.contains(item)){
//           selectedItems.remove(item);
//         }else{
//           print('sssssssssssssssssss${item}');
//           selectedItems.add({
//             'st_id':item['st_id'],
//             'id':item['id'],
//             'status':item['status'],
//           });
//           print(selectedItems);
//         }
//       });
//     }
//
//
//     List<Map<String,dynamic>> selectedItms = [
//       {
//         'st_id':13,
//         'id':104,
//         'status':'Delivered'
//       },
//       {
//         'st_id':13,
//         'id':105,
//         'status':'In Transist'
//       }
//     ];
//
//     // List<int> selectedItems = [];
//
//     Future<void> getTableData() async {
//       var requestBody = {
//         'log_id': Util.userLogedID,
//       };
//       final response = await http.post(
//         Uri.parse(AppUrl.getDetails),
//         headers: {
//           'Content-Type': 'application/json',
//           // Add any other headers you may need
//         },
//         body: jsonEncode(requestBody),
//       );
//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//
//         if (responseData is List) {
//           // Sort the list based on 'stockist_name' in ascending order
//           responseData.sort((a, b) =>
//               (a['stockist_name'] as String).compareTo(b['stockist_name'] as String));
//
//           setState(() {
//             Util.tableDataset = responseData;
//           });
//         } else if (responseData is Map<String, dynamic>) {
//           Util.tableDataset = [responseData];
//         }
//       } else {
//         print("Error: ${response.statusCode}, ${response.body}");
//       }
//     }
//
//
//
//     Future<void> changeStatus() async {
//       var requestBody = {
//         'updatedata':selectedItms
//       };
//       final response = await http.post(
//         Uri.parse(AppUrl.changeStatus),
//         headers: {
//           'Content-Type': 'application/json',
//           // Add any other headers you may need
//         },
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         // print("Success: ${response.body}");
//         var responseData = jsonDecode(response.body);
//         setState(() {
//           Util.tableDataset.clear();
//           if(responseData is List){
//             Util.tableDataset.addAll(responseData);
//           }else if(responseData is Map<String,dynamic>){
//             Util.tableDataset = [responseData];
//           }
//           // tableDataset.addAll(responseData);
//         });
//         // Do something with the response data
//       } else {
//         print("Error: ${response.statusCode}, ${response.body}");
//         // Handle the error
//       }
//     }
//
//     Future<bool> validateOTP(String enteredOTP) async {
//       // Replace this with your actual OTP validation logic
//       // You might want to make an API call or compare with a stored OTP
//       return enteredOTP == '1234';
//     }
//
//     @override
//     void initState() {
//       // TODO: implement initState
//       super.initState();
//     }
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.purple,
//           title: Text('Orders'),
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: FutureBuilder(
//                 future: getTableData(),
//                 builder: (context,snapshot) {
//                   if(snapshot.connectionState == ConnectionState.waiting){
//                     return Center(child: CircularProgressIndicator(),);
//                   }else if(snapshot.hasError){
//                     return Center(child: Text('Some Error Occured !'),);
//                   }else{
//                     return DataTable(
//                         columns: [
//                           DataColumn(
//                               label: Text('Select')
//                           ),
//                           // DataColumn(
//                           //   label: Text('ID'),
//                           // ),
//                           DataColumn(
//                             label: Text('Stockist'),
//                           ),
//                           // DataColumn(
//                           //   label: Text('Log ID'),
//                           // ),
//                           DataColumn(
//                             label: Text('To'),
//                           ),
//                           DataColumn(
//                             label: Text('Amount'),
//                           ),
//                           DataColumn(
//                             label: Text('Bill Num'),
//                           ),
//                           DataColumn(label:Text('Status'))
//                         ],
//                         rows: Util.tableDataset[0]['data'].map<DataRow>((data){
//                           return buildDataRow(data);
//                         }).toList(),
//                     onSelectAll: (isSelectedAll){
//                           setState(() {
//                             selectAll = isSelectedAll!;
//                             if(isSelectedAll){
//                               selectedItems.addAll(Util.tableDataset[0]['data']);
//                             }else{
//                               selectedItems.clear();
//                             }
//                           });
//
//                     },);
//                   }
//                 }
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     DataRow buildDataRow(Map<String, dynamic> data) {
//       bool isSelected = selectedItems.contains(data) || selectAll;
//
//       return DataRow(
//         cells: [
//           DataCell(
//             Checkbox(
//               value: isSelected,
//               onChanged: (_) {
//                 toggleSelection(data);
//               },
//             ),
//           ),
//           DataCell(Text(data['stockist_name'].toString())),
//           DataCell(GestureDetector(
//             onTap: (){
//               Util.selected_to = data['to'].toString();
//               print('selected to is :${Util.selected_to.toString()}');
//               Navigator.pushNamed(context, RoutesName.filteredPage);
//             },
//               child: Text(data['to'].toString()))),
//           DataCell(Text(data['amount'].toString())),
//           DataCell(Text(data['bill_num'].toString())),
//           DataCell(
//             CustomDropdown(
//               options: ['In Transit', 'Delivered'],
//               hintText: data['status'] == null ? '-' : data['status'].toString(),
//               onChanged: (value) {
//                 setState(() {
//                   Util.selected_Status = value.toString();
//                 });
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('Change Status'),
//                       content: Form(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             if (value == 'Delivered')
//                               TextFormField(
//                                 controller: _otpController,
//                                 decoration: InputDecoration(labelText: 'Enter OTP'),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter OTP';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             if (value == 'In Transit')
//                               TextFormField(
//                                 controller: _otpController,
//                                 decoration: InputDecoration(labelText: 'Enter OTP'),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter OTP';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             SizedBox(height: 20.0,),
//                             ElevatedButton(
//                               style:ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.purple
//                               ),
//                               onPressed: () async {
//                                 if (_formKey.currentState?.validate() ?? false) {
//                                   if (value == 'Delivered') {
//                                     String enteredOTP = _otpController.text;
//                                     if (await validateOTP(enteredOTP)) {
//                                       Util.selected_Status = value;
//                                       changeStatus();
//                                       Navigator.of(context).pop();
//                                     } else {
//                                       print('entered otp is wrong');
//                                     }
//                                   } else if (value == 'In Transit') {
//                                     String enteredOTP = _otpController.text;
//                                     if (await validateOTP(enteredOTP)) {
//                                       Util.selected_Status = value;
//                                       changeStatus();
//                                       Navigator.of(context).pop();
//                                     } else {
//                                       print('entered OTP is Wrong');
//                                     }
//                                   } else {
//                                     Util.selected_Status = value;
//                                     Navigator.of(context).pop();
//                                   }
//                                 }
//                               },
//                               child: Text('Submit'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     }
//
//
//
//     void onRowSelected(int itemId) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Change Status for Item ID: $itemId'),
//             content: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     controller: _otpController,
//                     decoration: InputDecoration(labelText: 'Enter OTP'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter OTP';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         String enteredOTP = _otpController.text;
//                         if (await validateOTP(enteredOTP)) {
//                           Util.selected_Status = 'Delivered'; // or 'In Transit'
//                           await changeStatus();
//                           Navigator.of(context).pop(); // Close the dialog
//                         } else {
//                           // Invalid OTP, handle accordingly
//                         }
//                       }
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }
