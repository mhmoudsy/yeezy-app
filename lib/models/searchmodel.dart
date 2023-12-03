import 'package:yeezy_store/models/productmodel.dart';

class SearchModel{
  String? message;
  bool? status;
  List<SearchDataModel>product=[];
  SearchModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
    status=json['status'];
    if(json['products']!=null){
      json['products'].forEach((element){
        product.add(SearchDataModel.fromJson(element));

      });
    }
  }

}

class SearchDataModel {
  int? id;
  String? productName;
  String? productDescription;
  String? productImage;
  int? productPrice;
  bool? inFavorite;
  bool? inCard;
  int? categoryId;
  int? quantity;
  List<SearchSizeModelData> sizes = [];


  SearchDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    inFavorite = json['in_favorite'];
    inCard = json['in_cart'];
    quantity = json['quantity'];
    categoryId = json['category_id'];
    if (json['sizes'] != null) {
      json['sizes'].forEach((element) {
        sizes.add(SearchSizeModelData.fromJson(element));
      });
    }

  }
}
class SearchSizeModelData {
  int? id;
  String? size;
  int? productId;
  SearchSizeModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    productId = json['product_id'];
  }
}
