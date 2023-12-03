import 'package:flutter/cupertino.dart';

abstract class ApiKey{
  static const register='register';
  static const login='login';
  static const usersPoint='users';
  static const category='categories';
  static const product='products';
  static const profile='profile';
  static const addReview='product/addReview';
  static const productReview='product/getReview';
  static const favorite='product/favorite';
  static const updateUser='user/update';
  static const updateImage='user/updateProfileImage';
  static const password='user/passwordUpdate';
  static const cart='product/cart';
  static const size='product/size';
  static const order='order';
  static const search='product/search';
  static const updateAddress='address';
  static const orderSearch='order/search';

}

