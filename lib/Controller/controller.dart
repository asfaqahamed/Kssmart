import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kssmart/Model/CurrentUserModel.dart';
import 'package:kssmart/Model/SavedUserModel.dart';
import 'package:kssmart/Model/UserModel.dart';
import 'package:kssmart/Pages/admincreatepage.dart';
import 'package:kssmart/Pages/userpage.dart';
import 'package:kssmart/Repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kssmart/Widget/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

ValueNotifier<CurrentUserModel> currentUser =
    new ValueNotifier(CurrentUserModel());

class Controller extends ControllerMVC {
  UserModel userData = UserModel();
  List<SavedUserModel> savedUserList = <SavedUserModel>[];
  GlobalKey<FormState> createUserFormKey;
  GlobalKey<FormState> createProjectFormKey;
  GlobalKey<FormState> LoginFormKey;
  OverlayEntry loader;

  Controller() {
    loader = Helper.overlayLoader(context);
    createUserFormKey = new GlobalKey<FormState>();
    createProjectFormKey = new GlobalKey<FormState>();
    LoginFormKey = new GlobalKey<FormState>();
  }

  loginAuth(userName, password) {
    if (LoginFormKey.currentState.validate()) {
      LoginFormKey.currentState.save();
      if (userName == 'Admin@kssmart.co') {
        if (userName == 'Admin@kssmart.co' && password == '123456') {
          setCurrentUser('admin');
          currentUser.value.auth = true;
          currentUser.value.userName = 'admin';
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AdminCreatePage()),
              (route) => false);
        } else {
          showToast("Admin PASSWORD WRONG", context,
              gravity: Toast.TOP, duration: Toast.LENGTH_LONG);
        }
      } else {
        try {
          final Future<QuerySnapshot> studentsStream = FirebaseFirestore
              .instance
              .collection("user")
              .where('userName', isEqualTo: userName)
              .where('password', isEqualTo: password)
              .get();
          studentsStream.then((value) {
            if (value.docs.length == 0) {
              showToast("USER NAME PASSWORD WRONG", context,
                  gravity: Toast.TOP, duration: Toast.LENGTH_LONG);
            } else {
              setCurrentUser(value.docs.first.get('userName'));
              currentUser.value.auth = true;
              currentUser.value.userName = value.docs.first.get('userName');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => UserPage()),
                  (route) => false);
            }
          });
        } catch (e) {
          print('gomma${e}');
        }
      }
    }
  }

  Future<void> listenForSavedUserList() async {
    savedUserList.clear();
    getSavedUser().then((value) {
      value.forEach((element) {
        setState(() {
          savedUserList.add(element);
        });
      });
    }).onError((error, stackTrace) {
      print(error);
    }).whenComplete(() {
      print(savedUserList.length);
    });
  }

  Future<void> addUser() async {
    if (createUserFormKey.currentState.validate()) {
      createUserFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      addUserRepo(userData).onError((error, stackTrace) {
        print(error);
      }).then((value) {
        showToast("USER ADDED SUCCESSFULLY", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  Future<void> addProject(id) async {
    if (createProjectFormKey.currentState.validate()) {
      createProjectFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      addProjectRepo(id, userData).onError((error, stackTrace) {
        print(error);
      }).then((value) {
        showToast("PROJECT ADDED SUCCESSFULLY", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  Future<void> updateUser(id) async {
    if (createUserFormKey.currentState.validate()) {
      createUserFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      updateBioRepo(id,userData).onError((error, stackTrace) {
        print(error);
      }).then((value){
        showToast("UPDATED BIO SUCCESSFULLY", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      }).whenComplete(() {
        setState((){
          currentUser.value.userName=userData.userName;
          setCurrentUser(userData.userName);
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          currentUser.notifyListeners();
        });
        Helper.hideLoader(loader);
      });
    }
  }

  void setCurrentUser(String) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', String);
    } catch (e) {
      print('SharedPre:$e');
    }
  }

  Future<CurrentUserModel> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
    if (currentUser.value.auth == false && prefs.containsKey('current_user')) {
      currentUser.value.auth = true;
      currentUser.value.userName = prefs.getString('current_user');
    } else {
      currentUser.value.auth = false;
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentUser.notifyListeners();
    return currentUser.value;
  }

  Future<void> logout() async {
    currentUser.value.auth = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }

  void showToast(String msg, context, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }

  void showToastPopup(String msg, context, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
