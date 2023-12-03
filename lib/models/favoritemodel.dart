import 'package:yeezy_store/models/productmodel.dart';

class FavoriteModel{
  bool? state;
  String? message;
  List<ProductModelData>data=[];
  FavoriteModel.fromJson(Map<String,dynamic>json){
    state=json['state'];
    message=json['message'];
    if(json['data']!=null){
      json['data'].forEach((element){
        data.add(ProductModelData.fromJson(element));
      });
    }
  }
}
