class LoginModel {
  String? message;
  bool? status;
  String? token;
  UserDate? date;
  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    status = json['status'];
    date = json['users'] != null ? UserDate.fromJson(json['users']) : null;
  }
}

class UserDate {
  int? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? password;
  String? image;

  UserDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    phoneNumber = json['phone_number'];
  }
}
