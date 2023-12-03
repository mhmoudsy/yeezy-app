
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/models/cartmodel.dart';
import 'package:yeezy_store/shared/constants.dart';

import '../style/NewIcons.dart';

class CartItem extends StatefulWidget {
   int index;



  CartModel cartModel;
  CartItem({Key? key, required this.index, required this.cartModel})
      : super(key: key);
  static List<int> size = [1, 2, 3, 4];

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
    int counter = 1;

  List<String?>filterSize=[];
  String? selectedSize;


    @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
      filterSize=cubit.sizes.where((element) =>element.productId==widget.cartModel.data[widget.index].id ).map((e) => e.size).toList();



        return Container(
          width: size.width,
          height: size.height * 0.202,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 30,
                  offset: Offset(0.5, 10),
                  spreadRadius: 5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),

            ),
                  child: Image(
                    image: NetworkImage(getImage(
                        widget.cartModel.data[widget.index].productImage!),),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.cartModel.data[widget.index].productName!,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${widget.cartModel.data[widget.index].productPrice}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),


                          Text(
                            "Size:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton(
                              value:  selectedSize,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 1,
                              hint: Text("XX"),
                              underline: Container(),
                               icon: Padding( //Icon at tail, arrow bottom is default icon
                                padding: EdgeInsets.only(left:5),
                               child:Icon(Icons.arrow_circle_down_sharp)
                               ),
                              items: filterSize
                                  .map((e) => DropdownMenuItem(

                                        child: Text("$e"),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedSize=value!;
                                });
                                cubit.changeSizeNumber(selectedSize!,widget.index);

                                print(cubit.sizeNumber);
                              })
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (cubit.count[widget.index] <= 1) {
                                cubit.changeIndex(++counter,widget.index);
                              }

                              cubit.changeIndex(--counter,widget.index);
                              print(cubit.count);
                              //decrement
                            },
                            child: CircleAvatar(
                              backgroundColor: HexColor('#dedede'),
                              radius: 14,
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(NewIcons.downArrow),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${counter}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeIndex(++counter,widget.index);
                              print(cubit.count);
                              //increment
                            },
                            child: CircleAvatar(
                              backgroundColor: HexColor('#dedede'),
                              radius: 14,
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(NewIcons.arrowUp),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              cubit.changeCarts(productId: widget.cartModel.data[widget.index].id!);
                              //increment
                            },
                            child: const CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.white,
                              child: Icon(NewIcons.bin),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
