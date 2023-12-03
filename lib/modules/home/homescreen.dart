import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_loading/card_loading.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/modules/carts/orderconfirmation.dart';
import 'package:yeezy_store/modules/category/allcategory.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';
import 'package:yeezy_store/shared/widgets/categoryitem.dart';
import 'package:yeezy_store/shared/widgets/drawerchild.dart';
import 'package:yeezy_store/shared/widgets/productitem.dart';

import '../../shared/style/colors.dart';
import '../../shared/widgets/appbar.dart';
import '../../shared/widgets/deftextform.dart';
import '../search/searchscreen.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: const Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              width: 270,
              child: DrawerChild(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 10),
                      child: AppBarWidget(
                          firstCircleColor: HexColor('#f2eeee'),
                          firstCircleIcon: NewIcons.Menu_close,
                          firstOnPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          isBadge: true,
                          badgeWidget: cubit.cartModel != null
                              ? Text('${cubit.cartModel!.data.length}')
                              : Text('0'),
                          lastCircleColor: HexColor('#f2eeee'),
                          lastCircleIcon: NewIcons.Bag_outlined,
                          lastOnPressed: () {
                            cubit.currentIndex = 2;
                            cubit.changeBottomNavIndex(cubit.currentIndex);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderConfirmationScreen()));
                      },
                      child: const Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Welcome to Yeezy.",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefTextForm(
                      readOnly: true,
                      controller: searchController,
                      validator: (value) {},
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                      textInputType: TextInputType.text,
                      hintText: 'Search for specific product...',
                      borderRadius: 20,
                      prefixIcon: const Icon(NewIcons.Search_outlined),
                      borderColor: HexColor('#f2eeee'),
                      filled: true,
                      colorFill: HexColor('#f2eeee'),
                      contentPadding: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const AutoSizeText(
                          'Choose Brand',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: splashOrHighlightColor,
                          highlightColor: splashOrHighlightColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllCategories()));
                          },
                          child: AutoSizeText(
                            'View All',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                        condition: cubit.categoryModel != null,
                        builder: (context) => SizedBox(
                              height: 60,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => CategoryItem(
                                        categoryModel: cubit.categoryModel!,
                                        index: index,
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 8,
                                      ),
                                  itemCount:
                                      cubit.categoryModel!.categories.length),
                            ),
                        fallback: (context) => SizedBox(
                              height: 60,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 8),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    const CardLoading(
                                  height: 60,
                                  width: 140,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                itemCount: 10,
                              ),
                            )),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const AutoSizeText(
                          'New Arraival',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: AutoSizeText(
                            'View All',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    cubit.productModel != null
                        ? ConditionalBuilder(
                            condition: cubit.products.isNotEmpty,
                            fallback: (context) => Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const AutoSizeText(
                                    "No Product Yet",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  LoadingAnimationWidget.fourRotatingDots(
                                      color: HexColor('#7a4dfe'), size: 30)
                                ],
                              ),
                            ),
                            builder: (context) => GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.productModel!.products.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ProductItem(
                                dataModel: cubit.productModel!.products[index],
                                index: index,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          calculateCrossAxisCount(context),
                                      crossAxisSpacing: 12.0,
                                      mainAxisExtent: 260),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) =>
                                const CardLoading(
                              height: 260,
                              width: 160,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        calculateCrossAxisCount(context),
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 260),
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
