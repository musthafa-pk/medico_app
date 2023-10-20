import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medicoapp/Util/routes/routes.dart';
import 'package:medicoapp/res/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('./assets/lottie/homeasset.json'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.newTablePage);
                  // Navigator.pushNamed(context, RoutesName.home);
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color:Colors.purple,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('My Orders',style: TextStyle(
                          fontFamily: 'Musthafa',
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
