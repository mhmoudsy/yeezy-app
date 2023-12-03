class PasswordModel{
  String? message;
  PasswordModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
  }
}