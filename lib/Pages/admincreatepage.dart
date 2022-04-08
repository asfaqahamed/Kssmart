import 'package:flutter/material.dart';
import 'package:kssmart/Controller/controller.dart';
import 'package:kssmart/Widget/CreateProjectWidget.dart';
import 'package:kssmart/Widget/CreateUserWidget.dart';
import 'package:kssmart/Widget/constant.dart';

import 'LoginPage.dart';

class AdminCreatePage extends StatefulWidget {
  const AdminCreatePage({Key key}) : super(key: key);

  @override
  _AdminCreatePageState createState() => _AdminCreatePageState();
}

class _AdminCreatePageState extends State<AdminCreatePage> {
  Option selectedOption = Option.CreateUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title: Text(
          'KS SMART',
          style: Theme.of(context)
              .textTheme
              .headline2
              .merge(TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(onPressed: (){
            Controller().logout();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = Option.CreateUser;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text('Create User')),
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = Option.CreateProject;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text('Create Project')),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (widget, animation) =>
                  ScaleTransition(child: widget, scale: animation),
              child: selectedOption == Option.CreateUser
                  ? CreateUserWidget()
                  : CreateProjectWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
