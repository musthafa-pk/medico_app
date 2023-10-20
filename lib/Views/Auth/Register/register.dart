import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medicoapp/Views/Auth/Register/register_controller.dart';
import 'package:medicoapp/res/app_colors.dart';

import '../../../Util/routes/routes.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final regController = Get.put(RegisterController());
  final formKey = GlobalKey<FormState>();

  /*Future<void> postData() async {
    var data = {
      'email': email.text,
      'password': password.text,
    };

    var responce = await post(Uri.parse("${Con.url}Register.php"),
        body: data);
    var res = jsonDecode(responce.body);

    print(res);

    if (res["Add"] == "User successfully Registered") {
      Fluttertoast.showToast(msg: 'User Successfully Registered');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    } else {
      Fluttertoast.showToast(msg: "User Successfully Registered");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors().purpleColor,
              AppColors().blueColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 55.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text('Sign Up',style: TextStyle(fontSize: 45,color: Colors.white),),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                              right: 15.0,
                              left: 15.0,
                              top: 12.0,
                            ),
                            child: TextFormField(
                              controller: regController.userName,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please Enter Your name";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Your Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                              right: 15.0,
                              left: 15.0,
                              top: 12.0,
                            ),
                            child: TextFormField(
                              controller: regController.businessName,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please Enter Your bussiness name";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Your Bussiness Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                              right: 15.0,
                              left: 15.0,
                              top: 12.0,
                            ),
                            child: TextFormField(
                              controller: regController.phoneNumber,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please Enter Your phone number";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Your Phone Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                              right: 15.0,
                              left: 15.0,
                              top: 12.0,
                            ),
                            child: TextFormField(
                              controller: regController.email,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please Enter Your Email";
                                } else if (!val.contains('@')) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Your Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.0,
                              right: 15.0,
                              left: 15.0,
                              top: 12.0,
                            ),
                            child: TextFormField(
                              controller: regController.password,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password Cannot be Empty";
                                } else if (val.length < 5) {
                                  return "Password must be 8 letters long";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Your Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              height: 45,
                              width: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    debugPrint("All Validation Passed");
                                    regController.createAccount(context);
                                    // Fluttertoast.showToast(msg: 'User Successfully Registered');
                                    //postData();
                                  }
                                },
                                child: Text('Signup',style: TextStyle(color: Colors.black),),
                              ),
                            ),
                          ),
                           TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesName.login);
                            },
                            child: Text(
                              "Already have an account ?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
