import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kssmart/Controller/controller.dart';
import 'package:kssmart/Pages/LoginPage.dart';
import 'package:kssmart/Pages/admincreatepage.dart';
import 'package:kssmart/Pages/userpage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
            ()=>loadData()
    );
  }

  void loadData() {
    print('Sname:${currentUser.value.userName}');
        try {
          if (currentUser.value.auth==false) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
          } else {
            if(currentUser.value.userName=='admin'){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AdminCreatePage()), (route) => false);
            }
            else{
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>UserPage()), (route) => false);
            }
          }
        } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
