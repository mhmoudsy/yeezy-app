import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/shared/extentions/string_extension.dart';
import 'package:yeezy_store/shared/widgets/appbar.dart';
import 'package:yeezy_store/shared/widgets/defaultMaterialButton.dart';

import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/deftextform.dart';

class UserAddressScreen extends StatelessWidget {
  UserAddressScreen({super.key});

  var countryController = TextEditingController();

  var cityController = TextEditingController();

  var addressDetailsController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        countryController.text =
            cubit.userModel!.user!.address!.country!.capitalize();
        countryController.selection =
            TextSelection.collapsed(offset: countryController.text.length);
        cityController.text =
            cubit.userModel!.user!.address!.city!.capitalize();
        cityController.selection =
            TextSelection.collapsed(offset: cityController.text.length);
        addressDetailsController.text =
            cubit.userModel!.user!.address!.addressDetails!.capitalize();
        addressDetailsController.selection =
            TextSelection.collapsed(offset: addressDetailsController.text.length);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBarWidget(
                        firstCircleColor: HexColor('#f2eeee'),
                        firstCircleIcon: Icons.arrow_back_ios_new,
                        firstOnPressed: () {
                          Navigator.pop(context);
                          // cubit.profileImage=null;
                        },
                        isThereCenter: true,
                        centerWidget: Text(
                          "Address",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        width: 200,
                        // color:Colors.red,
                        child: Lottie.asset('assets/images/HouseAsset.json'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: cubit.userModel != null,
                        builder: (context) => SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      WavyAnimatedText('Change Your Delivery Address'),
                                    ],
                                    repeatForever: true,
                                    isRepeatingAnimation: true,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(

                                    child: DefTextForm(
                                      scrollPadding: 500,
                                      controller: countryController,
                                      validator: (String? value) => value!.isEmpty
                                          ? 'Enter the country'
                                          : null,
                                      textInputType: TextInputType.text,
                                      label: const Text('Country'),
                                      textInputAction: TextInputAction.next,
                                      prefixIcon: const Icon(
                                        NewIcons.government,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DefTextForm(
                                      scrollPadding: 500,
                                      controller: cityController,
                                      validator: (String? value) => value!.isEmpty
                                          ? 'Enter the city'
                                          : null,
                                      textInputType: TextInputType.text,
                                      label: const Text('City'),
                                      textInputAction: TextInputAction.next,
                                      prefixIcon: const Icon(
                                        NewIcons.city,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              DefTextForm(
                                scrollPadding: 500,
                                controller: addressDetailsController,
                                validator: (String? value) => value!.isEmpty
                                    ? 'Enter the Address Details'
                                    : null,
                                textInputType: TextInputType.text,
                                label: const Text('Address Details'),
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ConditionalBuilder(
                                condition: state is! UpdateAddressLoadingState,
                                builder: (context) => DefaultMaterialButton(
                                    size: size.width,
                                    color: HexColor('#9874fb'),
                                    border: 20,
                                    isTextWidget: false,
                                    widget: DefaultTextStyle(
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 7.0,
                                            color: Colors.white,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          FlickerAnimatedText('Save'),

                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),

                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.updateAddress(
                                          country:
                                              countryController.text.capitalize(),
                                          city: cityController.text.capitalize(),
                                          addressDetails: addressDetailsController
                                              .text
                                              .capitalize(),
                                        );
                                      }
                                    }),
                                fallback: (context) => DefaultMaterialButton(
                                    isTextWidget: false,
                                    size: size.width,
                                    color: HexColor('#9874fb'),
                                    widget: LoadingAnimationWidget.discreteCircle(
                                        color: Colors.white, size: 30),
                                    onPressed: () {}),
                              )
                            ],
                          ),
                        ),
                        fallback: (context) => Container(
                            margin: EdgeInsets.only(top: size.height / 2.9),
                            child: LoadingAnimationWidget.waveDots(
                                color: HexColor('#6639b8'), size: 30)),
                      ),
                    ],
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
