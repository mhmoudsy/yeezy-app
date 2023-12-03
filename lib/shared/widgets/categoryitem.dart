import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/models/categorymodel.dart';
import 'package:yeezy_store/models/productmodel.dart';
import 'package:yeezy_store/modules/category/categoryproduct.dart';
import 'package:yeezy_store/shared/constants.dart';

import '../style/colors.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index;
   CategoryItem({super.key,required this.categoryModel,required this.index,});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashOrHighlightColor,
      highlightColor: splashOrHighlightColor,
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>CategoryDetails(categoryId: categoryModel.categories[index].id!, categoryModel: categoryModel.categories[index],),


                    // CategoryDetails(index1: index,categoryModel: categoryModel ,)
            ));
      },
      child: Container(
        width: 140,
        height: 60,
        decoration: BoxDecoration(
          color: HexColor('#f3eef0'),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: Image(image: NetworkImage(getImage(categoryModel.categories[index].categoryImage!)),width: 40),
                // margin: EdgeInsets.all(2.5),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(child: AutoSizeText(categoryModel.categories[index].categoryName!,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),))
            ],
          ),
        ),
      ),
    );
  }
}
