import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kssmart/Model/CurrentUserModel.dart';
import 'package:kssmart/Pages/LoginPage.dart';
import 'package:kssmart/Pages/splashscreen.dart';

import 'Controller/controller.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Controller().getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentUser,
        builder: (context, CurrentUserModel _currentUser, _) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Touche W03 Medium',
              primaryColor: Colors.white,
              disabledColor: Colors.grey,
              cardColor: Colors.lightBlue[50],
              secondaryHeaderColor: Color(0xFF043832).withOpacity(1.0),
              floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
              scaffoldBackgroundColor: Colors.white.withOpacity(0.93),
              hintColor: Color(0xFF919191),
              primaryColorLight: Colors.white,
              accentColor: Color(0xFF000000).withOpacity(1.0),
              backgroundColor: Colors.black,
              dividerColor: Color(0xFF8c98a8).withOpacity(0.1),
              focusColor: Color(0xFF2abd03).withOpacity(1.0),
              primaryColorDark:  Color(0xFF2abd03),

              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
                headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                headline3: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
                headline2: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.4),
                headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.4),
                subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black, height: 1.3),
                subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.black, height: 1.2),
                headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
                bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black, height: 1.2),
                bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xFF8c98a8).withOpacity(1.0), height: 1.7),
              ),
            ),
            home: SplashScreen(),
          );
        }
    );
  }
}


