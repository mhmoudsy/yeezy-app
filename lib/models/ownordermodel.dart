class OwnOrderModel{
  bool? status;
  String? message;
  List<OwnOrderDataModel>orderData=[];
  OwnOrderModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    if(json['products']!=null){
      json['products'].forEach((element){
        orderData.add(OwnOrderDataModel.fromJson(element));
      });
    }

  }
}
class OwnOrderDataModel{
  int? id;
  String? productName;
  String? productDescription;
  String? productImage;
  String? orderAddress;
  String? orderCreatedAt;
  String? size;
  dynamic productPrice;
  dynamic totalPrice;
  int? quantity;
  bool? isPaid;
  bool? isInTheWay;
  bool? isDelivered;
  bool? isPreparing;
  String? orderCode;

  OwnOrderDataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    productName=json['product_name'];
    productDescription=json['product_description'];
    productImage=json['product_image'];
    orderAddress=json['order_address'];
    orderCreatedAt=json['order_created_at'];
    size=json['size'];
    productPrice=json['product_price'];
    totalPrice=json['total_price'];
    quantity=json['quantity'];
    isPaid=json['is_paid'];
    isInTheWay=json['is_in_the_way'];
    isDelivered=json['is_delivered'];
    isPreparing=json['is_preparing'];
    orderCode=json['order_code'];

  }
}