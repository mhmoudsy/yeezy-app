class ProductSizeModel{
  String? message;
  List<SizesModel>sizes=[];
  ProductSizeModel.formJson(Map<String,dynamic>json){
    message=json['message'];
    if(json['sizes']!=null){
      json['sizes'].forEach((element){
        sizes.add(SizesModel.fromJson(element));
      });
    }
  }
}
class SizesModel{
  int? id;
  int? productId;
  String? size;
  SizesModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    productId=json['product_id'];
    size=json['size'];
  }
}