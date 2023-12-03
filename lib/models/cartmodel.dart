import 'package:yeezy_store/models/productmodel.dart';

class CartModel{
  bool? status;
  String? message;
  dynamic? subTotal;
  dynamic? total;
  List<ProductModelData>data=[];
  CartModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
  message=json['message'];
    subTotal=json['sub_total'];
    total=json['total'];
  if(json['product']!=null){
  json['product'].forEach((element){
  data.add(ProductModelData.fromJson(element));
  });
  }
  }


}