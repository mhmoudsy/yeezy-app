class ProductReviewModel{
  String? message;
  List<ReviewData>productReview=[];
  ProductReviewModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
    if(json['ProductReview']!=null){
      json['ProductReview'].forEach((element){
        productReview.add(ReviewData.fromJson(element));
      });
    }

  }
}
class ReviewData{
  int? id;
  String? content;
  dynamic? rating;
  int? productId;
  int? userId;
  ReviewUserDataModel? reviewUserDataModel;
  ReviewData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    content=json['content'];
    rating=json['rating'];
    productId=json['product_id'];
    userId=json['user_id'];
    reviewUserDataModel=json['users']!=null ?ReviewUserDataModel.fromJson(json['users']):null;

  }
}
class ReviewUserDataModel{
  int? id;
  String?userName;
  String?image;
  ReviewUserDataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    userName=json['username'];
    image=json['image'];
  }
}