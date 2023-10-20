import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medicoapp/Views/Auth/Login/login_controller.dart';
import 'package:medicoapp/res/app_colors.dart';

import '../../../Util/routes/routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = Get.put(LoginController());

  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // Future<void> postData() async {
  //   var data = {
  //     'email': email.text,
  //     'password': password.text,
  //   };
  //   var responce = await post(Uri.parse("${Con.url}Login.php"),
  //       body: data);
  //   var res = jsonDecode(responce.body);
  //   print(res);
  //   if (responce.statusCode == 200) {
  //     if (res['messages'] == "User successfully logged in") {
  //       var id = res["reg_id"];
  //       final spref = await SharedPreferences.getInstance();
  //       spref.setString("reg_id", id);
  //       Fluttertoast.showToast(msg: "Successfully logged in");
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return Home();
  //       }));
  //     }
  //   } else {
  //     Fluttertoast.showToast(msg: "Failed to log in");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors().purpleColor,
              AppColors().blueColor
            ],begin: Alignment.bottomRight,
            end: Alignment.topLeft
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome ,",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Musthafa'
              ),
            ),
            Text(
              "Back",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'Musthafa'
              ),
            ),
            Center(
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
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 15.0,
                            right: 15.0,
                            left: 15.0,
                            top: 12.0,
                          ),
                          child: TextFormField(
                            controller: loginController.userId,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please Enter Your Email";
                              } else if (!val.contains('@')) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Your Email',
                              hintStyle: TextStyle(color: Colors.grey),
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
                            controller: loginController.password,
                            obscureText: _obscurePassword,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Password Cannot be Empty";
                              } else if (val.length < 5) {
                                return "Password must be 8 letters long";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ?
                                      Icons.visibility_off
                                      :Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(color: Colors.grey),
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
                                  loginController.login(context);
                                  // Fluttertoast.showToast(msg: 'User Successfully Loged In');
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context)=>Navigation()));
                                  //postData();
                                }
                              },
                              child: Text('Login',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.signUp);
                          },
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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