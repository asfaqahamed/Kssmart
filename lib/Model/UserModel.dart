class UserModel{
  String userName;
  String password;
  DateTime dob;
  String projectName;
  String companyName;
  String catchPhrase;
  String website;
  String lat;
  String lng;

  UserModel();

  Map<String, Object> toJson() => {
    'userName':userName,
    'password':password,
    'dob':dob!=null?dob.toIso8601String():null,
    'projectName':projectName,
    'companyName':companyName,
    'catchPhrase':catchPhrase,
    'website':website,
    'lat':lat,
    'lng':lng,
  };
}