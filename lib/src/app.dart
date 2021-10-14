import 'package:agenda/src/core/services/user_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'core/constants/data.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login.dart';
import 'ui/pages/register_page.dart';

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  UserManagement _userManagement = new UserManagement();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.MAIN_TITLE,
      initialRoute: "/",
      theme: ThemeData(
          fontFamily: "Arvo Regular",
          brightness: Brightness.light,
          primaryColor: Colors.orange,
          accentColor: Colors.white,
          appBarTheme:  AppBarTheme(iconTheme: IconThemeData(color: Colors.white))
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settins){
        return MaterialPageRoute(builder: (BuildContext cn) {
          switch(settins.name){
            case "/":
              return LoginPage(_userManagement, context);
            case "/home": return HomePage(settins.arguments);
            case "/register":
              return RegisterPage();
          }
          return LoginPage(_userManagement, context);
        });
      },
    );
  }
}