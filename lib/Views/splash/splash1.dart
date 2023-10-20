import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicoapp/Util/routes/routes.dart';
import 'package:medicoapp/res/app_colors.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({Key? key}) : super(key: key);

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {

  double opacity = 1.0;

  changeOpacity(){
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        opacity = opacity == 0.0 ? 1.0 :0.0;
        changeOpacity();
      });
    });
  }
  @override
  void initState() {
    changeOpacity();
    // TODO: implement initState
    Timer(Duration(seconds: 5),
        ()=> Navigator.pushNamed(context, RoutesName.login));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children:<Widget> [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 2),
                    child: Center(
                      child: Text('Medico',style: TextStyle(
                        color: Colors.white,fontFamily: 'Musthafa',fontSize: 30
                      ),),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: opacity == 1 ? 0 : 1,
                    duration: Duration(seconds: 2),
                    child: Center(
                      child: Text('Medico',style: TextStyle(
                          color: Colors.grey,fontFamily: 'Musthafa',fontSize: 30
                      ),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
