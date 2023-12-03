class ProductModel {
  String? message;
  List<ProductModelData> products = [];

  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products.add(ProductModelData.fromJson(element));
      });
    }
  }
}

class ProductModelData {
  int? id;
  String? productName;
  String? productDescription;
  String? productImage;
  int? productPrice;
  bool? inFavorite;
  bool? inCard;
  int? categoryId;
  int? quantity;
  List<ProductSizeModelData> sizes = [];
  ProductModelData.fromJson(Map<String, dynamic> json) {
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
        sizes.add(ProductSizeModelData.fromJson(element));
      });
    }
  }
}

class ProductSizeModelData {
  int? id;
  String? size;
  int? productId;
  ProductSizeModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    productId = json['product_id'];
  }
}
