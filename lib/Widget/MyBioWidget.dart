import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kssmart/Controller/controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MyBioWiget extends StatefulWidget {
  const MyBioWiget({Key key}) : super(key: key);

  @override
  _MyBioWigetState createState() => _MyBioWigetState();
}

class _MyBioWigetState extends StateMVC<MyBioWiget> {
  Controller _con;

  _MyBioWigetState() : super(Controller()) {
    _con = controller;
  }

  DateTime _bDay;
  String Id;
  TextEditingController bDay = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user")
                .where("userName", isEqualTo: currentUser.value.userName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print('name:${currentUser.value.userName}');
                DocumentSnapshot course = snapshot.data.docs[0];
                Id = course.id;
                _con.userData.dob=DateTime.parse(course['dob']);
                bDay.text = DateFormat.yMd().format(DateTime.parse(course['dob']));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _con.createUserFormKey,
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
                            validator: (input) => input.length < 1
                                ? 'Please Enter UserName'
                                : null,
                            onSaved: (input) => _con.userData.userName = input,
                            initialValue: course['userName'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(color: Colors.black)),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  borderRadius: BorderRadius.circular(10)),
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
                            validator: (input) => input.length < 1
                                ? 'Please Enter Password'
                                : null,
                            onSaved: (input) => _con.userData.password = input,
                            initialValue: course['password'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(color: Colors.black)),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Date Of Birth',
                            style: Theme.of(context).textTheme.subtitle1),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 70,
                            width: double.infinity,
                            child: TextFormField(
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    height: 1.2),
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                focusNode: AlwaysDisabledFocusNode(),
                                controller: bDay,
                                onTap: () {
                                  _selectBirthDate(context);
                                },
                                //onSaved: (input) => _con.userData.dob=input.t,
                                validator: (input) => input.length < 1
                                    ? 'Please Select DOB'
                                    : null,
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF329841),
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: InkWell(
                            onTap: () {
                              _con.updateUser(Id);
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
                                'Submit',
                                style: Theme.of(context).textTheme.button,
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          )),
    );
  }

  _selectBirthDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _bDay != null ? _bDay : DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Theme.of(context).primaryColorDark,
                onPrimary: Colors.white,
                surface: Theme.of(context).primaryColorDark,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _bDay = newSelectedDate;
      _con.userData.dob = newSelectedDate;
      bDay
        ..text = DateFormat.yMd().format(_bDay)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: bDay.text.length, affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
