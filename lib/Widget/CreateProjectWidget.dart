import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kssmart/Controller/controller.dart';
import 'package:kssmart/Model/SavedUserModel.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProjectWidget extends StatefulWidget {
  const CreateProjectWidget({Key key}) : super(key: key);

  @override
  _CreateProjectWidgetState createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends StateMVC<CreateProjectWidget> {
  Controller _con;

  _CreateProjectWidgetState() : super(Controller()) {
    _con = controller;
  }
  String lat='';
  String lng='';
  String user;
  TextEditingController website=TextEditingController();
  String companyName;
  DateTime _projectDate;
  TextEditingController projectDate = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_con.listenForSavedUserList();
    _con.listenForSavedUserList();
    //_con.getSavedUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _con.createProjectFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Name',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 70,
                child: TextFormField(
                  validator: (input)=>input.length<1?'Please Enter ProjectName':null,
                  onSaved: (input)=>_con.userData.projectName=input,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: Colors.black)),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Project Date',
                  style:  Theme.of(context).textTheme.subtitle1
              ),
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
                      controller: projectDate,
                      onTap: () {
                        _selectProjectDate(context);
                      },
                      //initialValue: '12/11/2021',
                      //onSaved: (input) =>  widget.con.vehicleData.startDate = input,
                      validator: (input) =>
                      input.length < 1 ? 'Please Select Project Date' : null,
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
              Text('Company Details',style:  Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 8,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: DropdownButtonFormField(
                      value: companyName,
                      isExpanded: true,
                      validator: (value) => value == null ? "Please Select Company" : null,
                      focusColor: Theme.of(context).colorScheme.secondary,

                      items: _con.savedUserList.map((SavedUserModel map) {
                        return new DropdownMenuItem(
                          value: map.company.name,
                          child: new Text(map.company.name, style: new TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          //widget.con.drData.shopTypeId = value;
                          //_value = value;
                          companyName=value;
                          _con.userData.companyName=value;
                          for(int i=0;i<_con.savedUserList.length;i++){
                            if(_con.savedUserList[i].company.name==value){
                              website.text=_con.savedUserList[i].website;
                              _con.userData.website=_con.savedUserList[i].website;
                              lat=_con.savedUserList[i].address.geo.lat;
                              _con.userData.lat=_con.savedUserList[i].address.geo.lat;
                              lng=_con.savedUserList[i].address.geo.lng;
                              _con.userData.lng=_con.savedUserList[i].address.geo.lng;
                              _con.userData.catchPhrase=_con.savedUserList[i].company.catchPhrase;
                            }
                          }
                        });
                      }),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Website',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  controller:website,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: Colors.black)),
                  enabled: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Location',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: '$lat,$lng',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(TextStyle(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                      //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("user").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Container();
                    else {
                      List<DropdownMenuItem> Users = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        Users.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.get('userName')??' ',
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }
                      return Container(
                        height: 50,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              items: Users,
                              onChanged: (Value) {
                                setState(() {
                                  user=Value;
                                  print(Value);
                                });
                              },
                              value: user,
                              isExpanded: false,
                              hint: new Text(
                                "Assign User",
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () {
                    _con.addProject(user);
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
      ),
    );
  }
  _selectProjectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _projectDate != null ? _projectDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
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
      _projectDate = newSelectedDate;
      projectDate
        ..text = DateFormat.yMd().format(_projectDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: projectDate.text.length, affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
