import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kssmart/Controller/controller.dart';
import 'package:kssmart/Model/SavedUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kssmart/Model/UserModel.dart';

Future<List<SavedUserModel>> getSavedUser() async {
  final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {"Content-Type": "application/json"});
  List jsonResponse = json.decode(response.body);
  return jsonResponse.map((job) => new SavedUserModel.fromJSON(job)).toList();
}

Future<void> addUserRepo(UserModel userData) async {
  try {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    user
        .add(userData.toJson())
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  } catch (e) {
    print('repo:$e');
  }
}

Future<void> addProjectRepo(id,UserModel userData) {
  CollectionReference user =
  FirebaseFirestore.instance.collection('user');
  return user
      .doc(id)
      .update({'catchPhrase':userData.catchPhrase,'companyName':userData.companyName,'lat':userData.lat,'lng':userData.lng,'projectName':userData.projectName,'website':userData.website})
      .then((value) => print("Added Project"))
      .catchError((error) => print("Failed to Add Project: $error"));
}

Future<void> updateBioRepo(id,UserModel userData) {
  CollectionReference user =
  FirebaseFirestore.instance.collection('user');
  return user
      .doc(id)
      .update({'userName':userData.userName,'password':userData.password,'dob':userData.dob.toIso8601String()})
      .then((value){
        //currentUser.value.userName=userData.userName;
        print("Updated User");
  })
      .catchError((error) => print("Failed to Update User: $error"));
}
