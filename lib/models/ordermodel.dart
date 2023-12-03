class OrderModel{
  bool? status;
  String? message;
  List<OrderDataModel> products=[];
  OrderModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    if(json['products']!=null){
      json['products'].forEach((element){
        products.add(OrderDataModel.fromJson(element));
      });
    }
  }
}

class OrderDataModel{
  int? id;
  String? productName;
  String? productDescription;
  String? productImage;
  dynamic productPrice;
  bool? inFavorite;
  bool? inCart;
  int? categoryId;
  String? createdAt;
  int? quantity;
  OrderDataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    productName=json['product_name'];
    productDescription=json['product_description'];
    productImage=json['product_image'];
    productPrice=json['product_price'];
    inFavorite=json['in_favorite'];
    inCart=json['in_cart'];
    categoryId=json['category_id'];
    createdAt=json['created_at'];
    quantity=json['quantity'];
  }


}