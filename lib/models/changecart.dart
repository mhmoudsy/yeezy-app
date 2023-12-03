class ChangeCartModel{
  bool? status;
  String? message;
  ChangeCartModel.formJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}