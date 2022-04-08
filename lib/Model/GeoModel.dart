class GeoModel{
  String lat;
  String lng;
  GeoModel();
  GeoModel.fromJSON(Map<String, dynamic> jsonMap){
    try{
      lat = jsonMap['lat']!= null ? jsonMap['lat'] : '';
      lng = jsonMap['lng']!= null ? jsonMap['lng'] : '';
    }
    catch(e){
      print('GeoModel Error:$e');
    }
  }
}