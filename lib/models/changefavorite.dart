class ChangFavoritesModel{
  bool? status;
  String? message;
  ChangFavoritesModel.formJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}