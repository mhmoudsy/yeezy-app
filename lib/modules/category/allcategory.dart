import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/category/categorydetail.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/style/colors.dart';

import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/circle_icon.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:AppBarWidget(
                    firstCircleColor:HexColor('#f2eeee') ,
                    firstCircleIcon:Icons.arrow_back_ios_new ,
                    firstOnPressed: (){
                      Navigator.pop(context);
                    },
                    isThereCenter:true,
                    centerWidget: AutoSizeText('Available Categories',style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: ConditionalBuilder(
                    condition: cubit.categoryModel!=null ,
                    builder: (context)=>GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) =>InkWell(
                        splashColor: splashOrHighlightColor,
                        highlightColor: splashOrHighlightColor,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetail(categoryModel: cubit.categoryModel!,index: index,)));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: HexColor('#f2eeee'),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: NetworkImage(getImage(cubit.categoryModel!.categories[index].categoryImage!)),fit: BoxFit.cover,),

                              ],
                            ),
                          ),
                        ),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: calculateCrossAxisCount(context),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),

                    ),
                    fallback: (context)=>CircularProgressIndicator(),
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
