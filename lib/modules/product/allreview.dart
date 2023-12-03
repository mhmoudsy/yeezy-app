
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/product/addreview.dart';
import 'package:yeezy_store/modules/product/productdetails.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/extentions/string_extension.dart';

import '../../models/productreviewmodel.dart';
import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/circle_icon.dart';

class AllReview extends StatelessWidget {
  DateTime now = DateTime.now();
  int productId;
  int index;
  AllReview({super.key,required this.productId,required this.index});

  @override
  Widget build(BuildContext context) {



      return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          List<ReviewData>? filterProductReview = cubit.reviews.where((element) => element.productId == productId).toList();

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    AppBarWidget(
                        firstCircleColor:HexColor('#f2eeee') ,
                        firstCircleIcon:Icons.arrow_back_ios_new ,
                        firstOnPressed: (){
                          Navigator.pop(context);
                        },
                        isThereCenter:true,
                      centerWidget: Text("Reviews",style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w500
                            ),),
                    ),

                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${filterProductReview.length} Reviews',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        Spacer(),
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            backgroundColor: HexColor("#ff7043"),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ) ,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddReviewScreen(productId: productId, index: index,)));
                          }, child: Row(
                          children: [
                            Icon(Icons.pending_actions_outlined,color: Colors.white,),
                            SizedBox(width: 3,),
                            Text("Add Review",style: TextStyle(color: Colors.white),)
                          ],
                        ),),

                      ],
                    ),
                    SizedBox(height: 15,),
                    filterProductReview.isNotEmpty?
                    Expanded(
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context,index)=> Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      getImage(filterProductReview[index].reviewUserDataModel!.image!)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${filterProductReview[index].reviewUserDataModel!.userName!.capitalize()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          DateFormat('d MMM, yyyy')
                                              .format(now),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${filterProductReview[index].rating}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'rating',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    RatingBar.builder(
                                      initialRating: filterProductReview[index].rating!.toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 18,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: HexColor("#ff7043"),
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //reviewComment
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                '${filterProductReview[index].content!.capitalize()}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16
                                )),
                          ],
                        ),
                        separatorBuilder: (context,index)=>SizedBox(height: 8,),
                        itemCount: filterProductReview.length,

                      ),
                    ):Center(
                      child: Column(
                        children: [
                          LoadingAnimationWidget.staggeredDotsWave( color: HexColor('#fe7146'),size: 60),
                          Text('No reviews yet',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      );


  }
}
