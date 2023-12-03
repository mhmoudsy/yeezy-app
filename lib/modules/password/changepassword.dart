import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';
import 'package:yeezy_store/shared/widgets/appbar.dart';
import 'package:yeezy_store/shared/widgets/defaultMaterialButton.dart';

import '../../layouts/cubit/cubit.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/deftextform.dart';
import '../../shared/widgets/showprofileimage.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AppBarWidget(
                        firstOnPressed: (){
                          Navigator.pop(context);
                        },
                        firstCircleIcon: Icons.arrow_back_ios_new,
                        firstCircleColor: HexColor('#f2eeee')),

                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            AutoSizeText(
                              'Keep it secret and secure',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[500],
                                  fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DefTextForm(
                              controller: oldPasswordController,
                              label: Text('Password'),
                              textInputType: TextInputType.visiblePassword,
                              validator: (String? value) => value!.isEmpty
                                  ? 'Enter the old password'
                                  : null,
                              hintText: '123456789aA@',
                              prefixIcon: const Icon(NewIcons.lock_outline),
                              isObscure: cubit.isOldPassword,
                              textInputAction: TextInputAction.next,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffixPassword)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DefTextForm(
                              controller: newPasswordController,
                              label: Text('New Password'),
                              textInputType: TextInputType.visiblePassword,
                              validator: (String? value) => value!.isEmpty
                                  ? 'Enter new password'
                                  : value.length <= 8
                                      ? 'must be more than 8 number and character'
                                      : value != confirmPasswordController.text
                                          ? 'must meet confirm password'
                                          : null,
                              hintText: '123456789aA@',
                              prefixIcon: const Icon(NewIcons.lock_outline),
                              isObscure: cubit.isNewPassword,
                              textInputAction: TextInputAction.next,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changeNewPasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffixNewPassword)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DefTextForm(
                              controller: confirmPasswordController,
                              label: Text('Confirm Password'),
                              textInputType: TextInputType.visiblePassword,
                              validator: (String? value) => value!.isEmpty
                                  ? 'Enter confirm password'
                                  : value.length <= 8
                                      ? 'must be more than 8 number and character'
                                      : value != newPasswordController.text
                                          ? 'must meet new password'
                                          : null,
                              hintText: '123456789aA@',
                              prefixIcon: const Icon(NewIcons.lock_outline),
                              isObscure: cubit.isConfirmNewPassword,
                              textInputAction: TextInputAction.next,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changeConfirmPasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffixConfirmPassword)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      condition: state is! ChangeUserPasswordLoadingState,
                      builder: (context) => DefaultMaterialButton(
                          size: MediaQuery.of(context).size.width,
                          color: HexColor('#9874fb'),
                          text: 'Change',
                          border: 15,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.changePassword(
                                oldPassword: oldPasswordController.text,
                                newPassword: newPasswordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );
                            }
                          }),
                      fallback: (context) => MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          height: 60,
                          minWidth: MediaQuery.of(context).size.width,
                          color: HexColor('#f3f3f3'),
                          onPressed: () {},
                          child: LoadingAnimationWidget.flickr(
                              leftDotColor: HexColor('#9874fb'),
                              rightDotColor: HexColor('#ff5182'),
                              size: 40)),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
