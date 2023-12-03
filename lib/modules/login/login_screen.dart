import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/home_layout.dart';
import 'package:yeezy_store/modules/login/cubit/cubit.dart';
import 'package:yeezy_store/modules/login/cubit/states.dart';
import 'package:yeezy_store/modules/register/register_screen.dart';
import 'package:yeezy_store/shared/network/local/cache_helper.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';
import 'package:yeezy_store/shared/style/colors.dart';
import 'package:yeezy_store/shared/widgets/defaultMaterialButton.dart';

import '../../shared/constants.dart';
import '../../shared/widgets/deftextform.dart';
import '../../shared/widgets/textformfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailOrPhoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if(state.loginModel.status!){
                AnimatedSnackBar.rectangle(
                    brightness: Brightness.light,
                    'Success',
                    '${state.loginModel.message}',
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom
                ).show(
                  context,
                );
                CacheHelper.saveDate(key: 'userId', value: state.loginModel.date!.id);
                CacheHelper.saveDate(key: 'token', value: state.loginModel.token)
                .then((value) {
                  token=state.loginModel.token;
                  currentUserId=state.loginModel.date!.id;
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayout()), (route) => false);
                }).catchError((error){print(error.toString());});
              }
              }else if(state is LoginErrorState){
              AnimatedSnackBar.rectangle(
                  brightness: Brightness.light,
                  'Error',
                  '${state.loginModel.message}',
                  type: AnimatedSnackBarType.error,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom
              ).show(
                context,
              );
            }

          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
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
                        Container(
                          width: size.width,
                          child: Image(
                            image: const AssetImage('assets/images/AuthLogo.png'),
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
                        const AutoSizeText(
                          'Login to your Account..',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 15,),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              DefTextForm(
                                controller:emailOrPhoneController ,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter valid email/phone';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                hintText: "e.g xyz@gmail.com/011xxx",
                                label: const Text('Email/Phone'),
                                prefixIcon:const Icon(NewIcons.email_heart_outline),
                                borderWidth: 0.4,
                              ),
                              const SizedBox(height: 10,),
                              DefTextForm(
                                isObscure: cubit.isPassword,
                                controller: passwordController,
                                validator: (value) {
                                  if(value!.isEmpty && value.length <= 8){
                                    return 'please enter valid password';

                                  }
                                  return null;
                                },

                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                hintText: "e.g 01251#asd255",
                                label: const Text('Password'),
                                prefixIcon:const Icon(NewIcons.lock_outline),
                                borderWidth: 0.4,
                                suffixIcon: IconButton(onPressed: (){
                                  cubit.changePasswordVisibility();
                                }, icon: Icon(cubit.suffixPassword)),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        DefaultMaterialButton(
                          isTextWidget: true,
                            text: 'Sign in',
                            border: 18,
                            size: size.width,
                            color: HexColor('#172c86'),
                            onPressed: (){
                             if(formKey.currentState!.validate()){
                               cubit.loginMethod(
                                   emailOrPhone: emailOrPhoneController.text,
                                   password: passwordController.text);
                             }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText('Don\'t have an account?',),
                            InkWell(
                              highlightColor: splashOrHighlightColor,
                              splashColor: splashOrHighlightColor,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                              },
                              child: AutoSizeText('Sign up',style: TextStyle(
                                color: HexColor('#0d1b53'),
                                fontWeight: FontWeight.w500
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),





                  //                   ConditionalBuilder(
                  //                     condition: state is! LoginLoadingState,
                  //                     builder: (context) => Center(
                  //                       child: Container(
                  //                         width: size.width / 2,
                  //                         child: ElevatedButton(
                  //                           onPressed: () {
                  //
                  //                             if(formKey.currentState!.validate()){
                  //                               cubit.loginMethod(
                  //                                   emailOrPhone: emailOrPhoneController.text,
                  //                                   password: passwordController.text);
                  //                             }
                  //                           },
                  //                           style: ElevatedButton.styleFrom(
                  //                             backgroundColor: HexColor('#FF4184'),
                  //                           ),
                  //                           child: const Text(
                  //                             "LOGIN",
                  //                             style: TextStyle(color: Colors.white),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     fallback: (context) => const Center(
                  //                         child: CircularProgressIndicator()),
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //                       const Text("if you don\'t have an accout?"),
                  //                       TextButton(
                  //                         onPressed: () {
                  //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                  //                         },
                  //                         style: TextButton.styleFrom(
                  //                             padding: EdgeInsets.zero),
                  //                         child: const Text("REGISTER"),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ]),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            );
          },
        ),
      );

  }
}
