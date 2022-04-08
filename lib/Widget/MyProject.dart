import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kssmart/Controller/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kssmart/Pages/MapPage.dart';

class MyProjectWidget extends StatefulWidget {
  const MyProjectWidget({Key key}) : super(key: key);

  @override
  _MyProjectWidgetState createState() => _MyProjectWidgetState();
}

class _MyProjectWidgetState extends State<MyProjectWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user")
                .where("userName", isEqualTo: currentUser.value.userName)
                .snapshots(),
            builder: (context, snapshot) {
              DocumentSnapshot course = snapshot.data.docs[0];
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                        enabled: false,
                        initialValue: course['projectName'],
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
                                  color: Theme.of(context).primaryColorDark),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Company Details',
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
                        enabled: false,
                        decoration: InputDecoration(
                          hintText:
                              '${course['companyName']},${course['catchPhrase']}',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(TextStyle(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Website',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 70,
                      child: TextFormField(
                        enabled: false,
                        initialValue: course['website'],
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
                                  color: Theme.of(context).primaryColorDark),
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
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MapPage(lat: course['lat'],lng: course['lng'],projectName: course['projectName'],)));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: '${course['lat']},${course['lng']}',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                //borderSide: BorderSide(color: Theme.of(context).primaryColorDark)
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
