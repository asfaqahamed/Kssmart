import 'package:kssmart/Model/GeoModel.dart';

class AddressModel{
  String street;
  String suite;
  String city;
  String zipcode;
  GeoModel geo;
  AddressModel();

  AddressModel.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      street = jsonMap['street']!= null ? jsonMap['street'] : '';
      suite = jsonMap['suite']!= null ? jsonMap['suite'] : '';
      city = jsonMap['city']!= null ? jsonMap['city'] : '';
      zipcode = jsonMap['zipcode']!= null ? jsonMap['zipcode'] : '';
      geo = jsonMap['geo'] != null ? GeoModel.fromJSON(jsonMap['geo']) : GeoModel.fromJSON({});
    }
    catch(e){
      print('AddressModelError:$e');
    }
  }
}