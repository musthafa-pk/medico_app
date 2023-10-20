import 'package:flutter/material.dart';
import 'package:medicoapp/Util/routes/routes.dart';
import 'package:medicoapp/Views/Auth/Login/login.dart';
import 'package:medicoapp/Views/Auth/Register/register.dart';
import 'package:medicoapp/Views/Home.dart';
import 'package:medicoapp/Views/HomePage.dart';
import 'package:medicoapp/Views/filteredData.dart';
import 'package:medicoapp/Views/newTableset.dart';
import 'package:medicoapp/Views/splash/splash1.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RoutesName.splashOne:
        return MaterialPageRoute(builder: (BuildContext context) => SplashOne());

      case RoutesName.home1:
        return MaterialPageRoute(builder: (BuildContext context)=>Home());

      // case RoutesName.home:
        // return MaterialPageRoute(builder: (BuildContext context) => HomePage());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => Signup());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => Login());

      case RoutesName.filteredPage:
        return MaterialPageRoute(builder: (BuildContext context)=> FilteredDataPage());

      case RoutesName.newTablePage:
        return MaterialPageRoute(builder: (BuildContext context)=> FoodApp());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No Route Defined'),),
          );
        });
    }
  }
}
