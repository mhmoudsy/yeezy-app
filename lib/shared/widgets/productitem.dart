import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/models/productmodel.dart';
import 'package:yeezy_store/modules/product/productdetails.dart';
import 'package:yeezy_store/shared/constants.dart';

import 'package:yeezy_store/shared/style/NewIcons.dart';

import '../style/colors.dart';
class ProductItem extends StatelessWidget {
  dynamic dataModel;
  int index;


   ProductItem({super.key,required this.dataModel,required this.index});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=HomeCubit.get(context);
        return InkWell(
          splashColor: splashOrHighlightColor,
          highlightColor: splashOrHighlightColor,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(productModelData: dataModel,index: index,productId: dataModel.id!, )));

          },
          child: Container(
            height: 260,
            width: 160,
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 205,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),

                          ),
                          color: HexColor('#f3eef0')),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:  Image(
                        image: NetworkImage(
                            getImage(dataModel.productImage!)),fit: BoxFit.cover,
                      )
                      ,
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.changeFavorites(productId: dataModel.id!);
                      },
                      icon: cubit.favorites[dataModel.id]! ? Icon(NewIcons.Heart,color: Colors.red,):Icon(NewIcons.Heart_outlined),)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(

                  dataModel.productName!,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "\$${dataModel.productPrice!}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
