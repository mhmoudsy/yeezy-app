import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_loading/card_loading.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/test.dart';

import '../../shared/constants.dart';
import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/productitem.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var size=MediaQuery.of(context).size;
        var cubit=HomeCubit.get(context);
        return  Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: WillPopScope(
                onWillPop:() async {
                  cubit.currentIndex=0;
                  cubit.changeBottomNavIndex(cubit.currentIndex);
                  return false;
                } ,

               child:  SizedBox(
                 height: size.height,
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       AppBarWidget(
                         firstCircleColor:HexColor('#f2eeee') ,
                         firstCircleIcon:Icons.arrow_back_ios_new ,
                         firstOnPressed: (){
                           cubit.currentIndex=0;
                           cubit.changeBottomNavIndex(cubit.currentIndex);
                         },
                         isThereCenter:true,
                         centerWidget: Text("Wishlist",style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                             fontWeight: FontWeight.w500
                         ),),
                       ),

                       const SizedBox(height: 15),
                       cubit.favoriteModel==null ?Container(
                         margin: EdgeInsets.only(top: size.height/7),

                         child: Lottie.asset('assets/images/ErrorAsset.json'),
                       ):cubit.favoriteModel!.data.isNotEmpty?
                       ConditionalBuilder(
                         condition: state is! GetFavoriteLoadingState,
                         builder: (context)=>GridView.builder(
                             shrinkWrap: true,
                             itemCount: cubit.favoriteModel!.data.length,
                             physics: const NeverScrollableScrollPhysics(),
                             gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount:
                                 calculateCrossAxisCount(context),
                                 crossAxisSpacing: 10,
                                 mainAxisExtent: 260),
                             itemBuilder: (BuildContext context, int index) => ProductItem(dataModel: cubit.favoriteModel!.data[index], index: index,)
                         ),

                         fallback: (context)=> Container(
                           margin: EdgeInsets.only(right: size.width/2.3),
                           child: const CardLoading(
                             height: 260,
                             width: 160,
                             borderRadius:
                             BorderRadius.all(Radius.circular(20)),
                           ),
                         ),
                       ): Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Lottie.asset('assets/images/EmptyFavoriteAsset.json'),
                           AutoSizeText('Favorite is Empty,Like what you want..',style: TextStyle(
                               color: Colors.black54,
                               fontWeight: FontWeight.bold,
                               fontStyle: FontStyle.italic,
                               fontSize: 18
                           ),),
                           // SizedBox(height: 10,),
                           // LoadingAnimationWidget.flickr(leftDotColor: HexColor('#408aff'), rightDotColor: HexColor('#fec37b'), size: 30)
                         ],
                       ),
                     ],
                   ),
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
