import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/extentions/string_extension.dart';

import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/defaultMaterialButton.dart';
import '../../shared/widgets/deftextform.dart';
import '../../shared/widgets/showprofileimage.dart';

class AccountInformationScreen extends StatefulWidget {
  AccountInformationScreen({Key? key}) : super(key: key);

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  var userNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneNumberController = TextEditingController();

  var governController = TextEditingController();

  var cityController = TextEditingController();
  static final RegExp usernameAlphaExp = RegExp('[a-zA-Z]');
  static final RegExp emailRegExp =  RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
  static final RegExp phoneNumberRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  var formKey = GlobalKey<FormState>();
  bool isReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is UpdateUserDataSuccessState){
          Fluttertoast.showToast(msg: state.userModel.message!.capitalize(),backgroundColor: Colors.green);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        userNameController.text = cubit.userModel!.user!.userName!.capitalize();
        emailController.text = cubit.userModel!.user!.email!.capitalize();
        phoneNumberController.text = cubit.userModel!.user!.phoneNumber!;

        return Scaffold(
          body: SafeArea(
            child: WillPopScope(
              onWillPop: ()async{
                cubit.currentIndex=0;
                cubit.changeBottomNavIndex(cubit.currentIndex);
                return false;
              },
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppBarWidget(
                          firstCircleColor:HexColor('#f2eeee') ,
                          firstCircleIcon:Icons.arrow_back_ios_new ,
                          firstOnPressed: (){
                            Navigator.pop(context);
                            cubit.profileImage=null;
                          },
                          thereIsButtonAtLast: true,
                          lastButton:TextButton(
                            onPressed: () {
                              setState(() {
                                isReadOnly = !isReadOnly;
                              });
                              print(isReadOnly);
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )),
                        ),
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              InkWell(

                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoViewPage(imageUrl: getImage(cubit.userModel!.user!.image!)),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: cubit.profileImage == null
                                      ? NetworkImage(getImage(cubit.userModel!.user!.image!))
                                      : FileImage(cubit.profileImage!) as ImageProvider,

                                radius: 70,),
                              ),
                              Visibility(
                                visible: !isReadOnly,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 18,
                                    child: Icon(
                                      NewIcons.camera,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        DefTextForm(
                          controller: userNameController,
                          validator: (String? value) => value!.isEmpty
                              ? 'Enter you name'
                              : (usernameAlphaExp.hasMatch(value)
                                  ? null
                                  : 'Only Alphabets are allowed in a username'),
                          textInputType: TextInputType.text,
                          label: const Text('Username'),
                          readOnly: isReadOnly,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icon(
                            NewIcons.account_circle_outline,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DefTextForm(
                          controller: emailController,
                          validator: (String? value) => value!.isEmpty
                              ? 'Enter your name'
                              : (emailRegExp.hasMatch(value)
                                  ? null
                                  : "Enter valid email"),
                          textInputType: TextInputType.emailAddress,
                          label: Text('Email'),
                          textInputAction: TextInputAction.next,
                          readOnly: isReadOnly,
                          prefixIcon: Icon(
                            NewIcons.email_heart_outline,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DefTextForm(
                          controller: phoneNumberController,
                          validator: (String? value) => value!.isEmpty
                              ? 'Enter phone number'
                              : (phoneNumberRegExp.hasMatch(value)
                                  ? null
                                  : 'Enter valid phone'),
                          textInputType: TextInputType.phone,
                          label: Text('Phone'),
                          readOnly: isReadOnly,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icon(
                            NewIcons.cellphone_basic,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: DefTextForm(
                        //         controller: governController,
                        //         validator: (String? value) =>value!.isEmpty?'Enter a govern':null,
                        //         textInputType: TextInputType.phone,
                        //         label: Text('Govern'),
                        //         hintText: 'Cairo',
                        //         readOnly: isReadOnly,
                        //         textInputAction: TextInputAction.next,
                        //         prefixIcon: Icon(
                        //           NewIcons.government,
                        //           size: 25,
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 15,
                        //     ),
                        //     Expanded(
                        //       child: DefTextForm(
                        //         controller: cityController,
                        //         validator: (String? value)=>value!.isEmpty?'Enter a city':null,
                        //         textInputType: TextInputType.text,
                        //         label: Text('City'),
                        //         hintText: 'El Salam',
                        //         textInputAction: TextInputAction.next,
                        //         readOnly: isReadOnly,
                        //         prefixIcon: Icon(
                        //           NewIcons.city,
                        //           size: 25,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        if (!isReadOnly) ConditionalBuilder(
                          condition: state is ! UpdateUserDataLoadingState,
                          fallback:(context)=>Center(child:LoadingAnimationWidget.flickr(leftDotColor: HexColor("#9874f9"), rightDotColor: HexColor('#fe7146'), size: 40)),
                         builder: (context)=>DefaultMaterialButton(

                             size: double.infinity,
                             color: HexColor('#9874fb'),
                             text:'Save',
                             onPressed: () {

                               if(formKey.currentState!.validate()){
                                 cubit.updateUserData(
                                   userName: userNameController.text,
                                   email: emailController.text,
                                   phoneNumber: phoneNumberController.text,
                                 );
                               }
                             }),
                        ) else SizedBox(),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
