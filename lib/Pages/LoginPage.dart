import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kssmart/Widget/LoginBoxWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: LoginBoxWidget(),
          )),
    );
  }
}
