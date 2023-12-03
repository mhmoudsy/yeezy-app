import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:yeezy_store/models/categorymodel.dart';
import 'package:yeezy_store/shared/constants.dart';

import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/circle_icon.dart';

class CategoryDetail extends StatelessWidget {
  CategoryModel categoryModel;
  int index;
   CategoryDetail({super.key,required this.categoryModel,required this.index});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: size.width,
                      margin: EdgeInsets.only(top: 40),
                      child: Image(
                        image: NetworkImage(
                            getImage(categoryModel.categories[index].categoryImage!),),
                      ),
                    ),
                    SafeArea(
                      child:AppBarWidget(
                        firstCircleColor:HexColor('#f3eef0') ,
                        firstCircleIcon:Icons.arrow_back_ios_new ,
                        firstOnPressed: (){
                          Navigator.pop(context);
                        },
                        isThereLast: true,
                        lastCircleColor: HexColor('#f3eef0'),
                        lastOnPressed: () {},
                        lastCircleIcon:NewIcons.Bag_outlined ,
                      )
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                AutoSizeText('${categoryModel.categories[index].categoryName} Company',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                )),
                AutoSizeText('Product belong in stock ${categoryModel.categories[index].products.length}',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
                )),
                SizedBox(height: 10,),
                AutoSizeText('About ${'Adidas'}',style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                  fontWeight: FontWeight.bold,
                ),
                ),
                ReadMoreText(
                  '${categoryModel.categories[index].categoryDescription}',
                  trimLines: 3,
                  colorClickableText: Colors.black,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
