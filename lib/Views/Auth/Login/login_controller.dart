import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:medicoapp/Util/routes/routes.dart';
import 'package:medicoapp/Util/util.dart';
import 'package:medicoapp/res/app_url.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{

  final userId = TextEditingController();
  final password = TextEditingController();

  Future<void> login(context) async {
    // Replace 'your_api_endpoint' with your actual API endpoint
    var apiUrl = Uri.parse(AppUrl.login);

    // Replace 'your_request_body' with the data you want to send
    var requestBody = {
      'userid': userId.text,
      'password': password.text
    };

    try {
      print(AppUrl.login);
      var response = await http.post(
        apiUrl,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responsedata = jsonDecode(response.body);
        var msg = responsedata['message'];
        print(responsedata['data']['name']);
        Navigator.pushNamed(context, RoutesName.home1);
        Util.flushBarErrorMessage('${msg.toString()}', context);
        // Request was successful
        Util.userLogedID = responsedata['data']['id'];
        Util.userLoggedName = responsedata['data']['name'];
      } else {
        var responsedata = jsonDecode(response.body);
        Util.flushBarErrorMessage('${responsedata['message'].toString()}', context);
        // Request failed with an error code
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      Util.flushBarErrorMessage('Some error occured !', context);
      // An error occurred during the request
      print('Error: $error');
    }
  }

}