class RegisterModel {
  String? message;
  String? token;
  UserDate? date;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
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
    image = json['image'];
    password = json['password'];
    phoneNumber = json['phone_number'];
  }
}
