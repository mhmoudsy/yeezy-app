import 'package:yeezy_store/models/loginmodel.dart';

abstract class LoginState{}
class InitialState extends LoginState{}
class ChangePasswordLoginVisibilityState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState{
  final LoginModel loginModel;

  LoginErrorState(this.loginModel);
}

