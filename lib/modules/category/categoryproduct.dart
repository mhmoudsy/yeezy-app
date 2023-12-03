import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/models/categorymodel.dart';
import 'package:yeezy_store/models/productmodel.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/widgets/circle_icon.dart';
import 'package:yeezy_store/shared/widgets/productitem.dart';

import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/appbar.dart';

class CategoryDetails extends StatelessWidget {
  final int categoryId;
  CategoryDataModel categoryModel;

   CategoryDetails({super.key,required this.categoryId,required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =HomeCubit.get(context);
        List<ProductModelData>?filterProduct=cubit.products.where((element) =>element.categoryId==categoryModel.id ).toList();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      firstCircleColor:HexColor('#f2eeee') ,
                      firstCircleIcon:Icons.arrow_back_ios_new ,
                      firstOnPressed: (){
                        Navigator.pop(context);
                      },
                      isThereCenter:true,
                      centerWidget:Container(
                        decoration: BoxDecoration(
                          color: HexColor('#f2eeee'),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: 70,
                        height: 50,
                        alignment: Alignment.center,
                        child: Image(
                            image: NetworkImage(
                                getImage(categoryModel.categoryImage!)),
                            width: 40),
                        // margin: EdgeInsets.all(2.5),
                      ),
                      isThereLast: true,
                      lastOnPressed:(){} ,
                      lastCircleColor:HexColor('#f2eeee') ,
                      lastCircleIcon:NewIcons.Bag_outlined ,
                    ),
                    // Row(
                    //   children: [
                    //     CircleIcons(
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       icons: Icons.arrow_back_ios_new,
                    //       color: HexColor('#f2eeee'),
                    //     ),
                    //     Spacer(),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         color: HexColor('#f2eeee'),
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       ),
                    //       width: 70,
                    //       height: 50,
                    //       alignment: Alignment.center,
                    //       child: Image(
                    //           image: NetworkImage(
                    //               getImage(categoryModel.categoryImage!)),
                    //           width: 40),
                    //       // margin: EdgeInsets.all(2.5),
                    //     ),
                    //     const Spacer(),
                    //     CircleIcons(
                    //       onPressed: () {},
                    //       icons: NewIcons.Bag_outlined,
                    //       color: HexColor('#f2eeee'),
                    //     ),
                    //   ],
                    // ),
                    Text(
                      "${filterProduct.length} items",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      'Available in stock',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 20,),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount:filterProduct.length ,
                      physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            calculateCrossAxisCount(context),
                            crossAxisSpacing: 12.0,
                            mainAxisExtent: 260),
                        itemBuilder: (BuildContext context, int index) => ProductItem(dataModel: filterProduct[index], index: index,)
                        
                      ),

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
