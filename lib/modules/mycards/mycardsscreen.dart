import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';
import 'package:yeezy_store/shared/widgets/appbar.dart';

import '../../shared/constants.dart';
import '../../shared/style/OrderIcons.dart';
import '../../shared/widgets/deftextform.dart';
import '../../shared/widgets/orderitem.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({Key? key}) : super(key: key);

  var codeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return  Scaffold(
            backgroundColor: Colors.grey[100],
            body: SafeArea(

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarWidget(
                        firstCircleColor: HexColor('#f2eeee'),
                        firstCircleIcon: Icons.arrow_back_ios_new,
                        firstOnPressed: () {
                          cubit.currentIndex=0;
                          cubit.changeBottomNavIndex(cubit.currentIndex);
                        },
                        isThereCenter: true,
                        centerWidget: Text(
                          "Orders",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                     if (cubit.ownOrderModel!=null) Column(
                       crossAxisAlignment: CrossAxisAlignment.start,

                       children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/DeliverOrderAssets.png'),
                                  ),
                                  Text(
                                    'Order Tracker',
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Order Code :',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: DefTextForm(
                                        controller: codeController,
                                        validator: (String? value) {},
                                        textInputType: TextInputType.text,
                                        hintText: 'e.g YS-1252d5e89',
                                        filled: true,
                                        colorFill: Colors.white,
                                        contentPadding: 13,
                                        borderWidth: 0,
                                        borderColor: Colors.transparent,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          cubit.orderCodeSearch(
                                              code: codeController.text);
                                        },
                                        icon: const Icon(NewIcons.Search_outlined)),
                                  ],
                                ),
                                if(cubit.searchByCode.isNotEmpty) SizedBox(
                                  height: 10,
                                ),
                              if(cubit.searchByCode.isNotEmpty) Row(
                                  children: [
                                    Text(
                                      'Result:',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          cubit.clearCodeList();
                                        }, icon: Icon(Icons.clear))
                                  ],
                                ),
                                cubit.searchByCode.isNotEmpty?
                                  ListView.builder(
                                    itemBuilder: (context, index) {
                                      List<StepperData> stepperData = [
                                        StepperData(
                                            title: StepperText(
                                              "Order Placed",
                                              textStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            subtitle: StepperText(
                                                "Your order has been placed at 28-Sep-2023"),
                                            iconWidget: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                              ),
                                              child: const Icon(
                                                  OrderIcons.order_placed,
                                                  color: Colors.white),
                                            )),
                                        StepperData(
                                            title: StepperText(
                                                !cubit.searchByCode[0]
                                                        .isPreparing!
                                                    ? 'Preparing'
                                                    : 'Prepared',
                                                textStyle: TextStyle(
                                                    color: cubit.searchByCode[0].isPreparing!
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w500)),
                                            subtitle: StepperText(
                                                "Your order is being prepared"),
                                            iconWidget: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: cubit.searchByCode[0].isPreparing!
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30))),
                                              child: const Icon(
                                                  OrderIcons.preparation,
                                                  color: Colors.white),
                                            )),
                                        StepperData(
                                            title: StepperText("On the way",
                                                textStyle: TextStyle(
                                                    color: cubit.searchByCode[0].isInTheWay!
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w500)),
                                            subtitle: StepperText(
                                                "Our delivery executive is on the way to deliver your item"),
                                            iconWidget: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: cubit.searchByCode[0].isInTheWay!
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30))),
                                              child: const Icon(OrderIcons.onTheWay,
                                                  color: Colors.white),
                                            )),
                                        StepperData(
                                            title: StepperText("Delivered",
                                                textStyle: TextStyle(
                                                    color: cubit.searchByCode[0].isDelivered!
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w500)),
                                            subtitle: StepperText(
                                                "Your order is already delivery"),
                                            iconWidget: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: cubit.searchByCode[0].isDelivered!
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30))),
                                              child: const Icon(OrderIcons.delivered,
                                                  color: Colors.white),
                                            )),
                                      ];

                                      return AnotherStepper(
                                        stepperList: stepperData,
                                        stepperDirection: Axis.vertical,
                                        iconWidth: 40,
                                        iconHeight: 40,
                                        activeBarColor: Colors.green,
                                        verticalGap: 30,
                                        activeIndex: orderTracker(
                                            preparing: cubit.searchByCode[0].isPreparing!,
                                            onTheWay: cubit.searchByCode[0].isInTheWay!),
                                        barThickness: 8,
                                      );
                                    },
                                    itemCount: 1,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                  ):Lottie.asset('assets/images/OrderSearchEmpty.json'),
                              ],
                            ),
                          ),
                          if(cubit.ownOrderModel!.orderData.isNotEmpty)Column(
                            children: [
                              SizedBox(height: 15,),
                              Text('Your Orders :',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              )),
                            ],
                          ),
                          SizedBox(height: 15,),

                          ListView.separated(
                            shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context,index)=>OrderItem(index: index,ownOrderModel: cubit.ownOrderModel!),
                              separatorBuilder: (context,index)=>SizedBox(height: 10),
                              itemCount: cubit.ownOrderModel!.orderData.length)

                        ],
                      ) else Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/7),
                         child: Lottie.asset('assets/images/ErrorAsset.json')),
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
