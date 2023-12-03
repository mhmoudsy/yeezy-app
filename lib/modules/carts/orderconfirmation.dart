import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/mycards/mycardsscreen.dart';
import 'package:yeezy_store/modules/test.dart';
import 'package:yeezy_store/shared/widgets/appbar.dart';
import 'package:yeezy_store/shared/widgets/defaultMaterialButton.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppBarWidget(
                    firstCircleColor: HexColor('#f2eeee'),
                    firstCircleIcon: Icons.arrow_back_ios_new,
                    firstOnPressed: () {
                      cubit.currentIndex = 0;
                      cubit.changeBottomNavIndex(cubit.currentIndex);
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 2,
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                          image: AssetImage(
                              'assets/images/OrderConfirmation-1.png')),
                      Image(
                          image: AssetImage(
                              'assets/images/OrderConfirmation-2.png')),
                    ],
                  ),
                ),
                const AutoSizeText(
                  'Order Confirmed!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                   top:5,
                    left: 12,
                    right: 12,
                    bottom: 8
                  ),
                  child: AutoSizeText(
                    'Your order has been confirmed, we will send you confirmation email shortly.',
                    style: TextStyle(
                      fontSize: 16,
                     color: Colors.grey
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: DefaultMaterialButton(
                        size: MediaQuery.of(context).size.width,
                        isTextWidget: true,
                        text: "Go to Orders",
                        textColor: Colors.grey,
                        height: 50,
                        color: HexColor('#f5f5f5'),
                        onPressed: () {
                          cubit.currentIndex = 3;
                          cubit.changeBottomNavIndex(cubit.currentIndex);
                          Navigator.pop(context);
                        }),
                  ),
                ),
                const Spacer(),
                DefaultMaterialButton(
                    size: MediaQuery.of(context).size.width,
                    isTextWidget: true,
                    height: 70,
                    text: 'Continue Shopping',
                    color: HexColor('#9775fa'),
                    onPressed: () {
                      cubit.currentIndex = 0;
                      cubit.changeBottomNavIndex(cubit.currentIndex);
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
