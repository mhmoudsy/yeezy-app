import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/product/allreview.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/extentions/string_extension.dart';
import 'package:yeezy_store/shared/widgets/defaultMaterialButton.dart';

import '../../models/productreviewmodel.dart';
import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/appbar.dart';

class ProductDetails extends StatelessWidget {
  dynamic productModelData;
  int index;
  int productId;
  ProductDetails({
    super.key,
    required this.productModelData,
    required this.index,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        List<ReviewData>? filterProductReview = cubit.reviews
            .where((element) => element.productId == productId)
            .toList();

        return Scaffold(
          bottomSheet:Padding(
            padding: const EdgeInsets.all(15.0),
            child: DefaultMaterialButton(
              border: 20,
              size: size.width,
              color: HexColor('#9874fb'),
              text: !cubit.productIds.contains(productId) ? 'Add to Cart' : 'Remove From Cart',
              onPressed: () {
                if (productModelData.sizes.isNotEmpty) {
                  cubit.changeCarts(productId: productModelData.id!);
                  cubit.changeInCart();
                } else {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: 'Not Available',
                      desc: "Product Not Available Now..",
                      btnOkOnPress: () {})
                      .show();
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  width: size.width,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Stack(
                    children: [
                      Image(
                        image: NetworkImage(
                            getImage(productModelData.productImage!)),
                        height: 400,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SafeArea(
                          child: AppBarWidget(
                              firstCircleColor: HexColor('#ffffff'),
                              firstCircleIcon: Icons.arrow_back_ios_new,
                              firstOnPressed: () {
                                Navigator.pop(context);
                              },
                              isBadge: true,
                              badgeWidget: Text('${cubit.cartModel!.data.length}'),
                              lastCircleColor: HexColor('#ffffff'),
                              lastCircleIcon: NewIcons.Bag_outlined,
                              lastOnPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              AutoSizeText(
                                'Original Piece ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Spacer(),
                              AutoSizeText(
                                'Price',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              AutoSizeText(
                                '${productModelData.productName}',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              const Spacer(),
                              AutoSizeText(
                                '\$${productModelData.productPrice}',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            children: [
                              AutoSizeText(
                                'Size',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Spacer(),
                              AutoSizeText(
                                'Available',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          productModelData.sizes.isNotEmpty
                              ? SizedBox(
                                  height: 60,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Container(
                                      alignment: Alignment.center,
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: HexColor('#eeedf0'),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Text(
                                        "${productModelData.sizes[index].size}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    separatorBuilder: (context, state) =>
                                        const SizedBox(
                                      width: 8,
                                    ),
                                    itemCount: productModelData.sizes.length,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  "Not Available Now",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red.shade300),
                                )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Description",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ReadMoreText(
                            productModelData.productDescription!,
                            trimLines: 3,
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' Show more',
                            trimExpandedText: ' Show less',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              AutoSizeText(
                                'Reviews',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllReview(
                                                productId: productId,
                                                index: index,
                                              )));
                                },
                                child: const AutoSizeText(
                                  'View All',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          //reviewRow

                          filterProductReview.isNotEmpty
                              ? ListView.builder(
                                  reverse: true,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                getImage(
                                                    filterProductReview[index]
                                                        .reviewUserDataModel!
                                                        .image!)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filterProductReview[index]
                                                    .reviewUserDataModel!
                                                    .userName!
                                                    .capitalize(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.access_time_outlined,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    DateFormat('d MMM, yyyy')
                                                        .format(now),
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${filterProductReview[index].rating}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    'rating',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              RatingBar.builder(
                                                initialRating:
                                                    filterProductReview[index]
                                                        .rating!
                                                        .toDouble(),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 18,
                                                ignoreGestures: true,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      //reviewComment
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          filterProductReview[index]
                                              .content!
                                              .capitalize(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  itemCount: 1,
                                )
                              : Center(
                                  child: Text(
                                  "No Review yet",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red.shade300),
                                )),
                          const SizedBox(
                            height: 5,
                          ),
                           Row(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 22),
                                  ),
                                  Text('with VAT,SD',style: TextStyle(
                                    color: Colors.grey
                                  ),)
                                ],
                              ),
                              const Spacer(),
                              Text(
                                '\$${productModelData.productPrice}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60,),
              ],
            ),
          ),
        );
      },
    );
  }
}
