class UserModel {
  String? message;
  bool? status;
  UserDataModel? user;
  UserModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
    status=json['status'];
    user = json['user'] != null ? UserDataModel.fromJson(json['user']) : null;

  }
}

class UserDataModel{
  int? id;
  String? userName;
  String? email;
  String? phoneNumber;
  String? password;
  String? image;
  UserAddressModel? address;


  UserDataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    userName=json['username'];
    email=json['email'];
    image=json['image'];
    phoneNumber=json['phone_number'];
    password=json['password'];
    address = json['address'] != null ? UserAddressModel.fromJson(json['address']) : null;



  }


}
class UserAddressModel{
  int? id;
  String? country;
  String? city;
  String? addressDetails;
  int ?userId;
  UserAddressModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    country=json['country'];
    city=json['city'];
    addressDetails=json['address_details'];
    userId=json['user_id'];

  }
}