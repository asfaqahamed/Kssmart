class CompanyModel{
  String name;
  String catchPhrase;
  String bs;

  CompanyModel();

  CompanyModel.fromJSON(Map<String, dynamic> jsonMap){
    try{
      name = jsonMap['name']!= null ? jsonMap['name'] : '';
      catchPhrase = jsonMap['catchPhrase']!= null ? jsonMap['catchPhrase'] : '';
      bs = jsonMap['bs']!= null ? jsonMap['bs'] : '';
    }
    catch(e){
      print('CompanyModel Error:$e');
    }
  }
}