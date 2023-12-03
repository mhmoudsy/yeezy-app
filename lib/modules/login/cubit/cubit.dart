import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yeezy_store/modules/login/cubit/states.dart';
import 'package:yeezy_store/shared/end_points.dart';
import 'package:yeezy_store/shared/network/remote/dio_helper.dart';

import '../../../models/loginmodel.dart';
import '../../../shared/style/NewIcons.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp phoneRegex = RegExp(r'^01[0-9]{9}$');
  bool isPassword = true;
  LoginModel? loginModel;
  IconData suffixPassword = NewIcons.eye_off_outline;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixPassword =
    isPassword ? NewIcons.eye_off_outline : NewIcons.eye_outline;
    emit(ChangePasswordLoginVisibilityState());
  }

  void loginMethod({
    required String emailOrPhone,
    required String password,
     context,
  }) {
    if (emailRegex.hasMatch(emailOrPhone)) {
      emit(LoginLoadingState());

      DioHelper.postData(
          url: ApiKey.login,
          data: {
            'email': emailOrPhone,
            'password': password,
          }
      ).then((value) {
        if(value.statusCode==200){
          loginModel = LoginModel.fromJson(value.data);
          print(value.data['message']);
          print(loginModel!.date!.username);
          emit(LoginSuccessState(loginModel!));
        }else{
          loginModel = LoginModel.fromJson(value.data);
          emit(LoginErrorState(loginModel!));

        }




      });
    }
    else{
      emit(LoginLoadingState());

      DioHelper.postData(
          url: ApiKey.login,
          data: {
            'phone_number':emailOrPhone,
            'password':password,
          }
      ).then((value) {
        if(value.statusCode==200){
          loginModel = LoginModel.fromJson(value.data);
          print(value.data['message']);
          print(loginModel!.date!.username);
          emit(LoginSuccessState(loginModel!));
        }else{
          loginModel = LoginModel.fromJson(value.data);
          emit(LoginErrorState(loginModel!));
          print(loginModel!.message);

        }

      });

    }
  }
}
