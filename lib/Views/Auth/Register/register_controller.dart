import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medicoapp/Util/util.dart';

import '../../../Util/routes/routes.dart';
import '../../../res/app_url.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController{

  TextEditingController userName = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  Future<void> createAccount(context) async {
    // Replace 'your_api_endpoint' with your actual API endpoint
    var apiUrl = Uri.parse(AppUrl.register);

    // Replace 'your_request_body' with the data you want to send
    var requestBody = {
      'name': userName.text,
      'business_name':businessName.text,
      'phone':phoneNumber.text,
      'email':email.text,
      'password': password.text
    };

    try {
      print(jsonEncode(requestBody));
      print(AppUrl.register);
      var response = await http.post(
        apiUrl,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        Util.flushBarErrorMessage('User Registered Successfully !', context);
        print('success');
        Navigator.pushNamed(context, RoutesName.login);
        // Request was successful
        print('API Response: ${response.body}');
      } else {
        var rsponse = jsonDecode(response.body);
        var msg = response;
        Util.flushBarErrorMessage('${msg}', context);
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