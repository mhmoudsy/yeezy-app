import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:yeezy_store/modules/search/cubit/cubit.dart';
import 'package:yeezy_store/modules/search/cubit/states.dart';

import '../../shared/constants.dart';
import '../../shared/style/NewIcons.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/deftextform.dart';
import '../../shared/widgets/productitem.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleIcons(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icons: Icons.arrow_back_ios_new,
                      color: HexColor('#f2eeee'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefTextForm(
                      controller: searchController,
                      validator: (value) {},
                      onChange: (String? value) {
                        if (value!.isNotEmpty) {
                          cubit.productSearch(text: value);
                        }
                        if (searchController.text.isEmpty) {
                          cubit.productSearch(text: value);
                        }
                      },
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      label: const Text("Search"),
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
                    // if()

                    searchController.text.isNotEmpty
                        ? ConditionalBuilder(
                            condition: state is! ProductSearchLoadingState,
                            fallback: (context) => Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        10),
                                child: Center(
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                            color: HexColor('#827cf9'),
                                            size: 40))),
                            builder: (context) =>
                                cubit.searchModel!.product.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            cubit.searchModel!.product.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                ProductItem(
                                          dataModel:
                                              cubit.searchModel!.product[index],
                                          index: index,
                                        ),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    calculateCrossAxisCount(
                                                        context),
                                                crossAxisSpacing: 12.0,
                                                mainAxisExtent: 260),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10),
                                        child: Column(
                                          children: [
                                            Lottie.asset(
                                                'assets/images/NoDataInScearchAsset.json'),
                                            const AutoSizeText(
                                              'Product Not Available Now..',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 10),
                            child:
                                Lottie.asset('assets/images/SearchAsset.json')),
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
