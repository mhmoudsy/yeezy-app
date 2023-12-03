import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_loading/card_loading.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/shared/style/colors.dart';
import 'package:yeezy_store/shared/widgets/cartitem.dart';

import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/defaultMaterialButton.dart';
import '../../shared/widgets/textexpanded.dart';
import '../address/useraddress.dart';
import 'orderconfirmation.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is ConfirmOrderSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderConfirmationScreen()),);

        }else if(state is ConfirmOrderErrorState){
          print("Error");
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var size = MediaQuery.of(context).size;
        List<int> productQuantity = List.generate(cubit.productQuantity.length,
            (index) => cubit.productQuantity[index]! * cubit.count[index]);

     List<int> productPrice = List.generate(cubit.cartList.length,
            (index) => productQuantity[index] * cubit.cartModel!.data[index].productPrice!);
        int totalPrice = 0;
        for (int number in productPrice) {
          totalPrice += number;
        }



        return Scaffold(
          bottomSheet: cubit.cartModel != null
              ? Visibility(
                  visible: cubit.cartModel!.data.isNotEmpty,
                  child: TapTExpand(
                    iconColor: Colors.black,
                    closedHeight: 70,
                    scrollable: true,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    borderRadius: 30,

                    onTapPadding: 10,
                    color: HexColor('#f1ecee'),
                    openedHeight: cubit.radioValidate?size.height / 1.9:size.height /2,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order info',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Subtotal',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const Spacer(),
                            Text(
                              "\$$totalPrice",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Shipping cost',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Spacer(),
                            Text(
                              "\$0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Total',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const Spacer(),
                            Text(
                              "\$$totalPrice",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Cash',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const Spacer(),
                            Radio(
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              value: 1,
                              groupValue: cubit.selectedRadio,
                              activeColor: Colors.green,
                              onChanged: (val) {
                                cubit.setSelectedRadio(val!);
                                cubit.setRadioValidate(false);
                                print(cubit.selectedRadio);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Credit Card',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const Spacer(),
                            Radio(
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              value: 2,
                              groupValue: cubit.selectedRadio,
                              activeColor: Colors.green,
                              onChanged: (val) {
                                cubit.setSelectedRadio(val!);
                                print(cubit.selectedRadio);
                                cubit.setRadioValidate(false);

                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        if(cubit.radioValidate) const Text('Choose method of payment',style: TextStyle(color: Colors.red),),
                        DefaultMaterialButton(
                          size: size.width,
                          color: HexColor('#9874fb'),
                          text: 'Confirm Order',
                          onPressed: () {
                            print(productQuantity);
                            print(cubit.sizeNumber);
                            if (cubit.sizeNumber.contains("Null")) {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.scale,
                                      title: 'Size',
                                      desc: "Select size of product..",
                                      btnOkOnPress: () {})
                                  .show();
                            } else {
                              if(cubit.selectedRadio==0){
                                cubit.setRadioValidate(true);
                              }else if(cubit.selectedRadio==1){
                                cubit.setRadioValidate(false);
                                cubit.confirmOrder(
                                    productId: cubit.productIds,
                                    productQuantity: productQuantity,
                                    productSize: cubit.sizeNumber,
                                    address:'${cubit.userModel!.user!.address!.country!},'
                                        '${cubit.userModel!.user!.address!.city!},'
                                        '${cubit.userModel!.user!.address!.addressDetails!}'
                                );
                              }else{
                                cubit.makePayment(
                                    amount: cubit.cartModel!.total,
                                    currency: 'USD',
                                    productId: cubit.productIds,
                                    productQuantity: productQuantity,
                                    productSize: cubit.sizeNumber,
                                    address: '${cubit.userModel!.user!.address!.country!},'
                                    '${cubit.userModel!.user!.address!.city!},'
                                    '${cubit.userModel!.user!.address!.addressDetails!}',);
                              }

                            }
                          },
                        ),
                      ],
                    ),
                    title: const Text('Info',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                  ),
                )
              : const SizedBox(),


          body: SafeArea(
            child: WillPopScope(
              onWillPop: ()async{
                cubit.currentIndex=0;
                cubit.changeBottomNavIndex(cubit.currentIndex);
                return false;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBarWidget(
                        firstCircleColor: HexColor('#f2eeee'),
                        firstCircleIcon: Icons.arrow_back_ios_new,
                        firstOnPressed: () {
                          cubit.currentIndex = 0;
                          cubit.changeBottomNavIndex(cubit.currentIndex);
                        },
                        isThereCenter: true,
                        centerWidget: Text(
                          "Cart",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      cubit.cartModel == null && cubit.userModel==null
                          ? Container(
                              margin: EdgeInsets.only(top: size.height / 7),
                              child:
                                  Lottie.asset('assets/images/ErrorAsset.json'),
                            )
                          : cubit.cartModel!.data.isEmpty
                              ? Container(
                                  margin: EdgeInsets.only(top: size.height / 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                          'assets/images/EmptyCartAsset.json'),
                                      const AutoSizeText(
                                        "Cart is empty ,browse for more product",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 18),
                                      ),
                                      // SizedBox(height: 10,),
                                      // LoadingAnimationWidget.flickr(leftDotColor: HexColor('#408aff'), rightDotColor: HexColor('#fec37b'), size: 30)
                                    ],
                                  )) : ConditionalBuilder(
                                  condition: state is! GetCartLoadingState,
                                  builder: (context) => Column(
                                    children: [
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 10,
                                        ),
                                        itemBuilder: (context, index) => CartItem(
                                            index: index,
                                            cartModel: cubit.cartModel!),
                                        itemCount: cubit.cartModel!.data.length,
                                      ),
                                      const SizedBox(height: 20,),
                                      Column(

                                        children: [
                                          Row(
                                            children: [
                                              Text("Delivery Address",style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              Spacer(),
                                              InkWell(
                                                  splashColor: splashOrHighlightColor,
                                                  highlightColor: splashOrHighlightColor,
                                                  onTap: (){
                                                    if( cubit.userModel!.user!.address!=null)Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAddressScreen()));
                                                  },
                                                  child: Icon(Icons.arrow_forward_ios)),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          InkWell(
                                            splashColor: splashOrHighlightColor,
                                            highlightColor: splashOrHighlightColor,
                                            onTap: (){

                                              if( cubit.userModel!.user!.address!=null)Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAddressScreen()));
                                            },
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        border:Border.all(
                                                            color: Colors.grey
                                                        )
                                                    ),
                                                    child: const Image(image: AssetImage('assets/images/Location.png'))),
                                                const SizedBox(width: 5,),
                                                Flexible(
                                                  child: Container(
                                                    height: 75,
                                                    width: size.width,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5),
                                                          child: Text(
                                                            cubit.userModel!.user!.address!=null? '${cubit.userModel!.user!.address!.country!},'
                                                                '${cubit.userModel!.user!.address!.city!},'
                                                                '${cubit.userModel!.user!.address!.addressDetails!}':"Unknow",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              bottom: 10
                                                          ),
                                                          child: Text(
                                                            cubit.userModel!.user!.address!=null? '${cubit.userModel!.user!.address!.city!},':'Unknow',
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.grey
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],

                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  fallback: (context) => ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
                                    ),
                                    itemBuilder: (context, index) => CardLoading(
                                      width: size.width,
                                      height: size.height * 0.202,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    itemCount: cubit.cartModel!.data.length,
                                  ),
                                ),



                      const SizedBox(
                        height: 70,
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
