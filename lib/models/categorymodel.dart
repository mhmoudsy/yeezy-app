class CategoryModel {
  String? message;
  List<CategoryDataModel>categories=[];


  CategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['categories'] != null) {
      json['categories'].forEach((element) {
        categories.add(CategoryDataModel.fromJson(element));
      });
    }
  }
}

class CategoryDataModel {
  int? id;
  String? categoryName;
  String? categoryDescription;
  String? categoryImage;
  List<CategoryData>products = [];

  CategoryDataModel.fromJson(Map<String, dynamic>json){
    id = json['id'];
    categoryName = json['category_name'];
    categoryDescription = json['category_description'];
    categoryImage = json['category_image'];
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products.add(CategoryData.fromJson(element) );
      });
    }
  }
}

class CategoryData{
  int? id;
  String? productName;
  String? productDescription;
  String? productImage;
  int? productPrice;
  int? categoryId;

  CategoryData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    categoryId = json['category_id'];

  }

}
