import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kssmart/Controller/controller.dart';
import 'package:kssmart/Pages/admincreatepage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginBoxWidget extends StatefulWidget {
  const LoginBoxWidget({Key key}) : super(key: key);

  @override
  _LoginBoxWidgetState createState() => _LoginBoxWidgetState();
}

class _LoginBoxWidgetState extends StateMVC<LoginBoxWidget> {
  Controller _con;
  _LoginBoxWidgetState():super(Controller()){
    _con = controller;
  }
  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 346,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _con.LoginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Name',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 70,
                child: TextFormField(
                  controller: userName,
                  validator: (input)=>input.length<1?'Enter UserName':null,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: Colors.black)),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                        borderRadius: BorderRadius.circular(15)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(),
                child: TextFormField(
                  controller: password,
                  validator: (input)=>input.length<1?'Enter UserName':null,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: Colors.black)),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                        borderRadius: BorderRadius.circular(15)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () {
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCreatePage()));
                    _con.loginAuth(userName.text, password.text);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
