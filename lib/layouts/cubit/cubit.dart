import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/models/categorymodel.dart';
import 'package:http_parser/http_parser.dart';
import 'package:yeezy_store/models/changecart.dart';
import 'package:yeezy_store/models/ordersearchmodel.dart';
import 'package:yeezy_store/models/productmodel.dart';
import 'package:yeezy_store/models/productreviewmodel.dart';
import 'package:yeezy_store/models/usermodel.dart';
import 'package:yeezy_store/modules/carts/carts_screen.dart';
import 'package:yeezy_store/modules/favorite/favorite_screen.dart';
import 'package:yeezy_store/modules/home/homescreen.dart';
import 'package:yeezy_store/modules/mycards/mycardsscreen.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/network/remote/dio_helper.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';

import '../../models/cartmodel.dart';
import '../../models/changefavorite.dart';
import '../../models/favoritemodel.dart';
import '../../models/ordermodel.dart';
import '../../models/ownordermodel.dart';
import '../../models/passwordmodel.dart';
import '../../models/productsizemodel.dart';
import '../../shared/end_points.dart';
import '../../shared/stripekey.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  CategoryModel? categoryModel;
  int? userIndex;

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  static List<Color> colors = [
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
  ];
  List<Widget> screens = [
    HomeScreen(),
    const FavoriteScreen(),
    const CartsScreen(),
    MyOrdersScreen(),
  ];

  List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: const Icon(NewIcons.Home_outlined),
      activeIcon: const Icon(NewIcons.Home),
      title: const Text('Home'),
      selectedColor: colors[0],
    ),
    SalomonBottomBarItem(
        icon: const Icon(NewIcons.Heart_outlined),
        activeIcon: const Icon(
          NewIcons.Heart,
        ),
        selectedColor: colors[1],
        title: const Text('Favorite')),
    SalomonBottomBarItem(
      icon: const Icon(NewIcons.Bag_outlined),
      activeIcon: const Icon(NewIcons.Bag),
      title: const Text('Cart'),
      selectedColor: colors[2],
    ),
    SalomonBottomBarItem(
      icon: const Icon(NewIcons.Wallet_outlined),
      activeIcon: const Icon(NewIcons.Wallet),
      title: const Text('Orders'),
      selectedColor: colors[3],
    ),
  ];

  void getCategory() {
    emit(GetCategoryLoadingState());
    DioHelper.getData(url: ApiKey.category, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(GetCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryErrorState(error.toString()));
    });
  }

  ProductModel? productModel;
  List<ProductModelData> products = [];

  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};
  void getProduct() {
    emit(GetProductLoadingState());
    DioHelper.getData(url: ApiKey.product, token: token).then((value) {
      productModel = ProductModel.fromJson(value.data);
      productModel!.products.forEach((element) {
        products.add(element);
        favorites.addAll({element.id!: element.inFavorite!});
        carts.addAll({element.id!: element.inCard!});
      });

      emit(GetProductSuccessState());
      print(productModel!.products[1].quantity);
    }).catchError((error) {
      print(error.toString());
      emit(GetProductErrorState(error.toString()));
    });
  }

  ProductSizeModel? productSizeModel;
  List<SizesModel> sizes = [];
  void getSize() {
    emit(GetSizeLoadingState());
    DioHelper.getData(url: ApiKey.size, token: token).then((value) {
      productSizeModel = ProductSizeModel.formJson(value.data);
      productSizeModel!.sizes.forEach((element) {
        sizes.add(element);
      });

      emit(GetSizeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSizeErrorState(error.toString()));
    });
  }

  ProductReviewModel? productReviewModel;
  List<ReviewData> reviews = [];
  void getProductReview() {
    reviews.clear();
    emit(GetProductReviewLoadingState());
    DioHelper.getData(url: ApiKey.productReview, token: token).then((value) {
      productReviewModel = ProductReviewModel.fromJson(value.data);
      productReviewModel!.productReview.forEach((element) {
        reviews.add(element);
      });
      emit(GetProductReviewSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductReviewErrorState(error.toString()));
    });
  }

  void sendReview({
    required int userId,
    required int productId,
    required String content,
    required dynamic rating,
  }) {
    emit(AddProductReviewLoadingState());
    DioHelper.postData(
      url: ApiKey.addReview,
      token: token,
      data: {
        'product_id': productId,
        'user_id': userId,
        'content': content,
        'rating': rating,
      },
    ).then((value) {
      print("Done Add");

      emit(AddProductReviewSuccessState());
      getProductReview();
    }).catchError((error) {
      print(error.toString());
      emit(AddProductReviewErrorState(error.toString()));
    });
  }

  ChangFavoritesModel? changFavoritesModel;
  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesIconState());

    DioHelper.postData(
        url: ApiKey.favorite,
        token: token,
        data: {'product_id': productId}).then((value) {
      changFavoritesModel = ChangFavoritesModel.formJson(value.data);

      if (!changFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }

      emit(ChangeFavoritesSuccessState(changFavoritesModel!));
      print(value.data);
      getFavorites();
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState(error.toString()));
    });
  }

  FavoriteModel? favoriteModel;
  void getFavorites() {
    emit(GetFavoriteLoadingState());
    DioHelper.getData(url: ApiKey.favorite, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      // print(value.data.toString());
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      emit(GetFavoriteErrorState(error.toString()));
      print(error.toString());
    });
  }

  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: ApiKey.profile, token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.userName);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserData({
    required String userName,
    required String email,
    required String phoneNumber,
  }) {
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(url: ApiKey.updateUser, token: token, data: {
      "username": userName,
      "email": email,
      "phone_number": phoneNumber,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print("Done Update");
      profileImage != null ? updateProfileImage() : "";

      emit(UpdateUserDataSuccessState(userModel!));
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
      print(error.toString());
    });
  }

  File? profileImage;

  Future getProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickProfileImageErrorState());
    }
  }

  updateProfileImage() async {
    String fileName = profileImage!.path.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        profileImage!.path,
        filename: fileName,
        contentType: MediaType('image', 'jpg'),
      ),
      "type": "image/jpg"
    });
    print(fileName);
    emit(UpdateProfileImageLoadingState());

    DioHelper.postData(url: ApiKey.updateImage, data: formData, token: token)
        .then((value) {
      getUserData();
      emit(UpdateProfileImageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProfileImageErrorState(error.toString()));
    });
  }

  bool isOldPassword = true;
  bool isNewPassword = true;
  bool isConfirmNewPassword = true;
  IconData suffixPassword = NewIcons.eye_off_outline;
  IconData suffixNewPassword = NewIcons.eye_off_outline;
  IconData suffixConfirmPassword = NewIcons.eye_off_outline;
  void changePasswordVisibility() {
    isOldPassword = !isOldPassword;
    suffixPassword =
        isOldPassword ? NewIcons.eye_off_outline : NewIcons.eye_outline;
    emit(ChangePasswordState());
  }

  void changeNewPasswordVisibility() {
    isNewPassword = !isNewPassword;
    suffixNewPassword =
        isNewPassword ? NewIcons.eye_off_outline : NewIcons.eye_outline;
    emit(ChangePasswordState());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmNewPassword = !isConfirmNewPassword;
    suffixConfirmPassword =
        isConfirmNewPassword ? NewIcons.eye_off_outline : NewIcons.eye_outline;
    emit(ChangePasswordState());
  }

  PasswordModel? passwordModel;
  changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    emit(ChangeUserPasswordLoadingState());

    DioHelper.putData(
            url: ApiKey.password,
            data: {
              "old_password": oldPassword,
              "password": newPassword,
              "password_confirmation": confirmPassword,
            },
            token: token)
        .then((value) {
      passwordModel = PasswordModel.fromJson(value.data);
      print(passwordModel!.message);
      emit(ChangeUserPasswordSuccessState());
    }).catchError((error) {
      print(passwordModel!.message);

      print(error.toString());
      emit(ChangeUserPasswordErrorState(error.toString()));
    });
  }

  ChangeCartModel? changeCartModel;
  void changeCarts({required int productId}) {
    carts[productId] = !carts[productId]!;
    emit(ChangeCartLoadingState());

    DioHelper.postData(
        url: ApiKey.cart,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeCartModel = ChangeCartModel.formJson(value.data);

      if (!changeCartModel!.status!) {
        carts[productId] = !carts[productId]!;
      }
      print("Done Add To cart");

      emit(ChangeCartSuccessState(changeCartModel!));
      print(value.data);
      getCarts();
    }).catchError((error) {
      carts[productId] = !carts[productId]!;
      print(error.toString());
      emit(ChangeCartErrorState(error.toString()));
    });
  }

//new
  CartModel? cartModel;
  List<ProductModelData> cartList = [];
  List<int?> productIds = [];
  List<int?> productQuantity = [];
  List<int?> productPrice = [];

  List<int> count = [];
  void changeIndex(int index, int x) {
    count[x] = index;
    emit(CounterState());
  }

  List<String> sizeNumber = [];
  void changeSizeNumber(String currentSize, int index) {
    sizeNumber[index] = currentSize;
    emit(SizeState());
  }

  void getCarts() {
    emit(GetCartLoadingState());
    DioHelper.getData(url: ApiKey.cart, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      cartList.clear();
      cartModel!.data.forEach((element) {
        cartList.add(element);
      });

      //new
      count = List.filled(cartModel!.data.length, 1);
      sizeNumber = List.filled(cartModel!.data.length, "Null");
      productIds.clear();
      productQuantity.clear();

      productIds = cartList.map((e) => e.id).toList();
      productQuantity = cartList.map((e) => e.quantity = 1).toList();

      emit(GetCartSuccessState());

      print(cartModel!.subTotal);
    }).catchError((error) {
      emit(GetCartErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool inCart = false;
  void changeInCart() {
    inCart = !inCart;
    emit(InCartState());
  }

  OrderModel? orderModel;

  Future<void> confirmOrder(
      {required List productId,
      required List productQuantity,
      required List productSize,
      required String address,
      bool isPaid = false}) async {
    emit(ConfirmOrderLoadingState());
    await DioHelper.postData(url: ApiKey.order, token: token, data: {
      "product_id": productId,
      "product_quantity": productQuantity,
      "size": productSize,
      "address": address,
      "is_paid": isPaid,
    }).then((value) {
      orderModel = OrderModel.fromJson(value.data);
      getOwnOrder();
      print("Done Update");
      emit(ConfirmOrderSuccessState());
    }).catchError((error) {
      emit(ConfirmOrderErrorState(error.toString()));
      print(error.toString());
    });
  }

  String? x;
  Future<String> getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    await dio.post('https://api.stripe.com/v1/payment_intents',
        options: Options(headers: {
          'Authorization': 'Bearer ${StripeKey.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        }),
        data: {
          'amount': amount,
          'currency': currency,
        }).then((value) {
      x = value.data["client_secret"];
      emit(GetClientSecretSuccessState());
    }).catchError((error) {
      emit(GetClientSecretErrorState(error.toString()));
      print(error.toString());
    });
    return x!;
  }

  Future<void> initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: "Mahmoud",
    ));
  }

  Future<void> makePayment(
      {required int amount,
      required String currency,
      required List productId,
      required List productQuantity,
      required List productSize,
      required String address,
      bool isPaid = false}) async {
    String clientSecret =
        await getClientSecret((amount * 100).toString(), currency);
    await initializePaymentSheet(clientSecret).then((value) {
      Stripe.instance.presentPaymentSheet().then((value) {
        confirmOrder(
            productId: productId,
            productQuantity: productQuantity,
            productSize: productSize,
            address: address,
            isPaid: true);
        emit(PaymentMethodSuccessState());
      }).catchError((error) {
        if (error is StripeException) {
          print('Throw Exception From Canceled Sheet');
        }
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  int selectedRadio = 0;
  setSelectedRadio(int val) {
    selectedRadio = val;
    emit(RadioSuccessState());
  }

  bool radioValidate = false;
  setRadioValidate(bool val) {
    radioValidate = val;
    emit(RadioValidateSuccessState());
  }

  void updateAddress({
    required String country,
    required String city,
    required String addressDetails,
  }) {
    emit(UpdateAddressLoadingState());
    DioHelper.putData(
      token: token,
      url: ApiKey.updateAddress,
      data: {
        'country': country,
        'city': city,
        'address_details': addressDetails,
      },
    ).then((value) {
      emit(UpdateAddressSuccessState());

      getUserData();

      print("Done");
    }).catchError((error) {
      emit(UpdateAddressErrorState(error.toString()));
      print(error.toString());
    });
  }
  OwnOrderModel? ownOrderModel;
  void getOwnOrder()  {
    emit(GetOwnOrdersLoadingState());
    DioHelper.getData(
      url: ApiKey.order,
      token: token,
    ).then((value) {
      ownOrderModel=OwnOrderModel.fromJson(value.data);
      emit(GetOwnOrdersSuccessState());
     if(ownOrderModel!.orderData.isNotEmpty) print(ownOrderModel!.orderData[0].orderCode);

    }).catchError((error) {
      print(error.toString());
      emit(GetOwnOrdersErrorState(error.toString()));

    });
  }
  //totalPrice Logic

  OrderSearchModel? orderSearchModel;
  List<OrderSearchDataModel>searchByCode=[];

  void orderCodeSearch({required String code}) {

    emit(OrderCodeSearchLoadingState());
    DioHelper.postData(
      url: ApiKey.orderSearch,
      token: token,
      data: {
        'order_code':code
      },).then((value) {
      orderSearchModel=OrderSearchModel.fromJson(value.data);
      orderSearchModel!.orderData.forEach((element) {
        searchByCode.add(element);
      });
      emit(OrderCodeSearchSuccessState());
      // orderSearchModel!.orderData.forEach((element) {
      //   searchByCode.add(element);
      // });
      if(orderSearchModel!.orderData.isNotEmpty) print(orderSearchModel!.orderData[0].isPreparing);
    }).catchError((error){
      print(error.toString());
      emit(OrderCodeSearchErrorState(error.toString()));

    });
  }
  void clearCodeList(){
    searchByCode.clear();
    emit(OrderCodeSearchClearSuccessState());
  }
}
