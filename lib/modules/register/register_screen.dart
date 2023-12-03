import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yeezy_store/modules/register/cubit/cubit.dart';
import 'package:yeezy_store/modules/register/cubit/states.dart';
import 'package:yeezy_store/shared/widgets/appbar.dart';
import 'package:yeezy_store/shared/widgets/defaultMaterialButton.dart';
import 'package:yeezy_store/shared/widgets/deftextform.dart';

import '../../shared/style/NewIcons.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var userNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var passwordConfirmationController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  // String regCode="1";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            AnimatedSnackBar.rectangle(
              'Success',
              '${state.registerModel.message}',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom
            ).show(
              context,
            );
            phoneController.clear();
            passwordConfirmationController.clear();
            passwordController.clear();
            emailController.clear();
            userNameController.clear();
          }else if(state is RegisterErrorState){
            AnimatedSnackBar.rectangle(
              brightness: Brightness.light,
                'Error',
                '${state.registerModel.message}',
                type: AnimatedSnackBarType.error,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom
            ).show(
              context,
            );
          }

        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: HexColor('ffffff'),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarWidget(
                        firstCircleColor: HexColor('#ffffff'),
                        firstCircleIcon: Icons.arrow_back_ios_new,
                        firstOnPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        width: size.width,
                        child: Image(
                          image: AssetImage('assets/images/AuthLogo.png'),
                          width: size.width * 0.60,
                          height: size.height * 0.25,
                        ),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(380, 80),
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AutoSizeText(
                        'Create your Account..',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15,),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            DefTextForm(
                                controller: userNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter valid name';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "e.g Mahmoud",
                              label: Text('Username'),
                              prefixIcon:const Icon(NewIcons.account_circle_outline),
                              borderWidth: 0.4,
                            ),
                            SizedBox(height: 10,),
                            DefTextForm(
                                controller: emailController,
                                validator: (value) =>userNameController.text.isEmpty?
                                null:!cubit.emailRegex.hasMatch(value!)?'please enter valid email':null,

                                textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              hintText: "e.g Mahmoud@admin.com",
                              label: const Text('Email'),
                              prefixIcon:const Icon(NewIcons.email_heart_outline),
                              borderWidth: 0.4,
                            ),
                            SizedBox(height: 10,),
                            // IntlPhoneField(
                            //   controller: phoneController,
                            //   textInputAction: TextInputAction.next,
                            //   keyboardType: TextInputType.phone,
                            //   decoration: InputDecoration(
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(18),
                            //       borderSide: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.4,
                            //       ),
                            //     ),
                            //     contentPadding: EdgeInsets.all(15),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(18),
                            //       borderSide: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.4,
                            //       ),
                            //     ),
                            //     errorBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //       borderSide: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.4,
                            //       ),
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //       borderSide: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.4,
                            //       ),
                            //     ),
                            //     hintText: "e.g 01111223366",
                            //     label: const Text('Phone'),
                            //   ),
                            //   validator: (value) =>emailController.text.isEmpty?
                            //   null:!cubit.phoneRegex.hasMatch(value as String)?'please enter valid phone':null,
                            //   onCountryChanged: (change){
                            //     print(change.dialCode);
                            //     regCode=change.dialCode  ;
                            //
                            //   },
                            // ),
                            DefTextForm(
                                controller: phoneController,
                                validator: (value)=>emailController.text.isEmpty?
                                null:!cubit.phoneRegex.hasMatch(value!)?'please enter valid phone':null,


                                textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              hintText: "e.g 01111223366",
                              label: const Text('Phone'),
                              prefixIcon:const Icon(NewIcons.cellphone_basic),
                              borderWidth: 0.4,
                            ),
                            SizedBox(height: 10,),
                            DefTextForm(
                                controller: passwordController,
                                isObscure: cubit.isPassword,
                                validator: (value)=>phoneController.text.isEmpty?null: value!.isEmpty
                                    ? 'enter valid password'
                                    : value.length <= 8
                                    ? 'must be more than 8 number and character'
                                    : value != passwordConfirmationController.text
                                    ? 'must match confirm password'
                                    : null,
                                textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              hintText: "e.g 21422xya%#",
                              label: const Text('Password'),
                              prefixIcon:const Icon(NewIcons.lock_outline),
                              borderWidth: 0.4,
                              suffixIcon:IconButton(onPressed: (){
                                cubit.changePasswordVisibility();
                              }, icon: Icon(cubit.suffixPassword),) ,
                            ),
                            SizedBox(height: 10,),
                            DefTextForm(
                                controller: passwordConfirmationController,
                                isObscure: cubit.isConfirm,
                                validator: (value)=>passwordController.text.isEmpty?null: value!.isEmpty
                                  ? 'enter valid confirm password'
                                : value.length <= 8
                                    ? 'must be more than 8 number and character'
                                : value != passwordController.text
                              ? 'must match password'
                              : null,
                                textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              hintText: "e.g 21422xya%#",
                              label: const Text('Confirm Password'),
                              prefixIcon:const Icon(NewIcons.lock_outline),
                              borderWidth: 0.4,
                              suffixIcon:IconButton(onPressed: (){
                                cubit.changeConfirmVisibility();
                              }, icon: Icon(cubit.suffixConfirm),) ,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      DefaultMaterialButton(
                          size: size.width,
                          height: 60,
                          isTextWidget: true,
                          text: 'Sign Up',
                          border: 15,
                          color: HexColor('#1c35a3'),
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.registerMethod(
                                phone:phoneController.text ,
                                passwordConfirmation:passwordConfirmationController.text ,
                                password:passwordController.text ,
                                email:emailController.text ,
                                userName:userNameController.text
                              );

                            }
                          }),


                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
