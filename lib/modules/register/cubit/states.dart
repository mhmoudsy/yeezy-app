import '../../../models/registermodel.dart';

abstract class RegisterState{}
class InitialState extends RegisterState{}
class ChangePasswordVisibilityState extends RegisterState{}
class ChangeConfirmPasswordVisibilityState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{
  final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends RegisterState{
  final RegisterModel registerModel;
  RegisterErrorState(this.registerModel);
}
