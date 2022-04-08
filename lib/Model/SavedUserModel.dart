import 'package:kssmart/Model/AddressModel.dart';
import 'package:kssmart/Model/CompanyModel.dart';

class SavedUserModel{
  int id;
  String name;
  String userName;
  String email;
  AddressModel address;
  String phone;
  String website;
  CompanyModel company;

  SavedUserModel();

  SavedUserModel.fromJSON(Map<String, dynamic> jsonMap){
    try{
      id = jsonMap['id']!= null ? jsonMap['id'] : '';
      name = jsonMap['name']!= null ? jsonMap['name'] : '';
      userName = jsonMap['userName']!= null ? jsonMap['userName'] : '';
      email = jsonMap['email']!= null ? jsonMap['email'] : '';
      address = jsonMap['address']!= null ? AddressModel.fromJSON(jsonMap['address']) :AddressModel.fromJSON({});
      phone = jsonMap['phone']!= null ? jsonMap['phone'] : '';
      website = jsonMap['website']!= null ? jsonMap['website'] : '';
      company = jsonMap['company']!= null ? CompanyModel.fromJSON(jsonMap['company']) : CompanyModel.fromJSON({});
    }
    catch(e){
      print('SavedUserModel Error:$e');
    }
  }
}