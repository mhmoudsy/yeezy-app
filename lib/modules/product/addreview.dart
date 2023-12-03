
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/product/allreview.dart';
import 'package:yeezy_store/shared/constants.dart';

import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/defaultMaterialButton.dart';

class AddReviewScreen extends StatefulWidget {

  int productId;
  int index;
  AddReviewScreen({super.key,required this.productId,required this.index});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  var contentController = TextEditingController();

  var formKey=GlobalKey<FormState>();
  dynamic star=1;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=HomeCubit.get(context);
        return Scaffold(
          bottomNavigationBar: DefaultMaterialButton(
            color: HexColor('#9874fb'),
            size: size.width,
            text: 'Submit Review',
            onPressed: (){
              if(formKey.currentState!.validate()){
                cubit.sendReview(
                  userId: currentUserId!,
                  content: contentController.text,
                  rating: star,
                  productId: widget.productId,

                );
              }else{
                Dialogs.materialDialog(
                    msg: 'Please enter your opinion about product',
                    title: "Alert",
                    color: Colors.white,
                    context: context,
                    actions: [
                      IconsOutlineButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Ok',
                        textStyle: TextStyle(color: Colors.grey),
                      ),

                    ]);
              }
            },
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                      centerWidget: Text(
                        "Add Reviews",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Text('How was your experience ?',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 10,
                    ),

                    Form(
                      key: formKey,
                      child: SizedBox(
                        height: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: contentController,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'here';
                            }
                          },
                          expands: true,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: 'Describe your experience',
                              filled: true,
                              fillColor: HexColor('#f3eef0'),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Star",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 10,),
                    Center(
                      child: RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            star=rating;
                          });

                        },
                      ),
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
