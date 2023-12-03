import 'package:yeezy_store/models/changecart.dart';
import 'package:yeezy_store/models/usermodel.dart';

import '../../models/changefavorite.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavIndexState extends HomeStates {}

class ShowDrawerState extends HomeStates {}

class GetCategoryLoadingState extends HomeStates {}

class GetCategorySuccessState extends HomeStates {}

class GetCategoryErrorState extends HomeStates {
  final String error;

  GetCategoryErrorState(this.error);
}

class GetProductLoadingState extends HomeStates {}

class GetProductSuccessState extends HomeStates {}

class GetProductErrorState extends HomeStates {
  final String error;

  GetProductErrorState(this.error);
}

class GetSizeLoadingState extends HomeStates {}

class GetSizeSuccessState extends HomeStates {}

class GetSizeErrorState extends HomeStates {
  final String error;

  GetSizeErrorState(this.error);
}

class GetProductReviewLoadingState extends HomeStates {}

class GetProductReviewSuccessState extends HomeStates {}

class GetProductReviewErrorState extends HomeStates {
  final String error;

  GetProductReviewErrorState(this.error);
}

class GetUsersLoadingState extends HomeStates {}

class GetUsersSuccessState extends HomeStates {}

class GetUsersErrorState extends HomeStates {
  final String error;

  GetUsersErrorState(this.error);
}

class AddProductReviewLoadingState extends HomeStates {}

class AddProductReviewSuccessState extends HomeStates {}

class AddProductReviewErrorState extends HomeStates {
  final String error;

  AddProductReviewErrorState(this.error);
}

class ChangeFavoritesLoadingState extends HomeStates {}

class ChangeFavoritesSuccessState extends HomeStates {
  ChangFavoritesModel changFavoritesModel;
  ChangeFavoritesSuccessState(this.changFavoritesModel);
}

class ChangeFavoritesErrorState extends HomeStates {
  final String error;

  ChangeFavoritesErrorState(this.error);
}

class ChangeFavoritesIconState extends HomeStates {}

class GetFavoriteLoadingState extends HomeStates {}

class GetFavoriteSuccessState extends HomeStates {}

class GetFavoriteErrorState extends HomeStates {
  final String error;
  GetFavoriteErrorState(this.error);
}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {
  final String error;
  GetUserDataErrorState(this.error);
}

class UpdateUserDataLoadingState extends HomeStates {}

class UpdateUserDataSuccessState extends HomeStates {
  UserModel userModel;
  UpdateUserDataSuccessState(this.userModel);
}

class UpdateUserDataErrorState extends HomeStates {
  final String error;

  UpdateUserDataErrorState(this.error);
}

class PickProfileImageSuccessState extends HomeStates {}

class PickProfileImageErrorState extends HomeStates {}

class UpdateProfileImageLoadingState extends HomeStates {}

class UpdateProfileImageSuccessState extends HomeStates {}

class UpdateProfileImageErrorState extends HomeStates {
  final String error;

  UpdateProfileImageErrorState(this.error);
}

class ChangePasswordState extends HomeStates {}

class ChangeUserPasswordLoadingState extends HomeStates {}

class ChangeUserPasswordSuccessState extends HomeStates {}

class ChangeUserPasswordErrorState extends HomeStates {
  final String error;

  ChangeUserPasswordErrorState(this.error);
}

class ChangeCartLoadingState extends HomeStates {}

class ChangeCartSuccessState extends HomeStates {
  ChangeCartModel changeCartModel;
  ChangeCartSuccessState(this.changeCartModel);
}

class ChangeCartErrorState extends HomeStates {
  final String error;

  ChangeCartErrorState(this.error);
}

class GetCartLoadingState extends HomeStates {}

class GetCartSuccessState extends HomeStates {}

class GetCartErrorState extends HomeStates {
  final String error;
  GetCartErrorState(this.error);
}

class InCartState extends HomeStates {}

class CounterState extends HomeStates {}

class SizeState extends HomeStates {}

class ConfirmOrderLoadingState extends HomeStates {}

class ConfirmOrderSuccessState extends HomeStates {}

class ConfirmOrderErrorState extends HomeStates {
  final String error;

  ConfirmOrderErrorState(this.error);
}

class GetClientSecretSuccessState extends HomeStates {}

class GetClientSecretErrorState extends HomeStates {
  final String error;

  GetClientSecretErrorState(this.error);
}
class PaymentMethodSuccessState extends HomeStates{}
class RadioSuccessState extends HomeStates{}
class RadioValidateSuccessState extends HomeStates{}

class UpdateAddressLoadingState extends HomeStates {}

class UpdateAddressSuccessState extends HomeStates {}

class UpdateAddressErrorState extends HomeStates {
  final String error;

  UpdateAddressErrorState(this.error);
}

class GetOwnOrdersLoadingState extends HomeStates {}

class GetOwnOrdersSuccessState extends HomeStates {}

class GetOwnOrdersErrorState extends HomeStates {
  final String error;

  GetOwnOrdersErrorState(this.error);
}
class OrderCodeSearchLoadingState extends HomeStates {}

class OrderCodeSearchSuccessState extends HomeStates {}

class OrderCodeSearchErrorState extends HomeStates {
  final String error;

  OrderCodeSearchErrorState(this.error);
}

class OrderCodeSearchClearSuccessState extends HomeStates {}