import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yeezy_store/models/registermodel.dart';
import 'package:yeezy_store/modules/register/cubit/states.dart';
import 'package:yeezy_store/shared/network/remote/dio_helper.dart';

import '../../../shared/end_points.dart';
import '../../../shared/style/NewIcons.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp phoneRegex = RegExp(r'^01[0-9]{9}$');
  bool isPassword = true;
  bool isConfirm = true;
  IconData suffixPassword = NewIcons.eye_off_outline;
  IconData suffixConfirm = NewIcons.eye_off_outline;
  RegisterModel? registerModel;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixPassword = isPassword ? NewIcons.eye_off_outline : NewIcons.eye_outline;
    emit(ChangePasswordVisibilityState());
  }

  void changeConfirmVisibility() {
    isConfirm = !isConfirm;
    suffixConfirm = isConfirm ? NewIcons.eye_off_outline : NewIcons.eye_outline;
    emit(ChangeConfirmPasswordVisibilityState());
  }
String? message;
  Future<void> registerMethod({
    String? userName,
    String? email,
    String? phone,
    String? password,
    String? passwordConfirmation,
  })async {
    emit(RegisterLoadingState());

     await DioHelper.postData(url: ApiKey.register, data: {
      'username': userName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone_number': phone,
    }).then((value) {
          if(value.statusCode==200){
            registerModel=RegisterModel.fromJson(value.data);
            print(registerModel!.message);

            emit(RegisterSuccessState(registerModel!));
          }else{
            print('Error..');
            print(value.statusCode);
            registerModel=RegisterModel.fromJson(value.data);
            emit(RegisterErrorState(registerModel!));
            print(registerModel!.message);

          }




    });
  }
}
