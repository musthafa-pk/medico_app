import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../res/app_url.dart';
class Util{
  static int? userLogedID;

  static String? userLoggedName;

  static String? selected_Status;

  static String? selected_to;

  static List<dynamic> tableDataset = [];

  static List<dynamic> filtertableDataset = [];
  // filterdataapi

  static Future<void> filterdata() async {
    var requestBody = {
      'log_id': userLogedID,
      'to':selected_to.toString()
    };
    final response = await http.post(
      Uri.parse(AppUrl.filterData),
      headers: {
        'Content-Type': 'application/json',
        // Add any other headers you may need
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      // print("Success: ${response.body}");
      var responseData = jsonDecode(response.body);
      // print(responseData);

      if (responseData is List) {
        print('its list');
        // If the response data is a List, directly set it to tableDataset
        // setState(() {
        filtertableDataset = responseData;
        // });
      } else if (responseData is Map<String, dynamic>) {
        print('map');
        // If the response data is a Map, extract the desired data and set it to tableDataset
        // setState(() {
        filtertableDataset = [responseData];
        print('last map is : ${filtertableDataset}');
        // });
      }

      // Do something with the response data
    } else {
      print("Error: ${response.statusCode}, ${response.body}");
      // Handle the error
    }
  }




  // ----------------------------------
  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );}


  static flushBarErrorMessage(String message , BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.error ,size: 28,color: Colors.white,),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.purple,
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
      )..show(context),
    );}

  static snackBar(String message , BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(message))
    );
  }

}