import 'package:flutter/material.dart';

var baseUrl='http://192.168.1.8/api/';
var apiLink='http://192.168.1.8';
String? token;
int? currentUserId;
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
String getImage(String profileImage){
  String image=profileImage;
  Uri uri = Uri.parse(image);
  String remainingPath = uri.path;
  return apiLink+remainingPath;
}

int orderTracker({
  required bool preparing,
  required bool onTheWay,
}){
  int index=1;
  if(preparing&&!onTheWay){
    index=2;
  }else if(preparing&&onTheWay){
    index=3;
  }
return index;
}
String governAddress(String address){
  String govern;
  if(address=="Unknown"){
    govern="Unknown";
  }else{
    List<String> substrings = address.split(" ");
    govern=substrings[0].trim();


  }
  return govern;

}
String cityAddress(String address){
  String city;
  if(address=="Unknown"){
    city="Unknown";
  }else{
    List<String> substrings = address.split(" ");
    city=substrings.sublist(1).join(' ').trim();


  }
  return city;

}

int calculateCrossAxisCount(context) {
  double screenWidth = MediaQuery.of(context).size.width;
  int crossAxisCount = (screenWidth / 150).floor(); // Adjust the item width as needed
  return crossAxisCount;
}
 double textSize(BuildContext context, double size) {
double width = MediaQuery.of(context).size.width;
return (size * width) / 100;
}
int quantity=1;