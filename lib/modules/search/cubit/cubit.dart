import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yeezy_store/modules/search/cubit/states.dart';
import 'package:yeezy_store/shared/constants.dart';

import '../../../layouts/cubit/cubit.dart';
import '../../../models/searchmodel.dart';
import '../../../shared/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super (SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;
  void productSearch({required String text}) {
    emit(ProductSearchLoadingState());
    DioHelper.postData(
      url: ApiKey.search,
      token: token,
      data: {
        'text':text
      },).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      print(searchModel!.product.length);
      emit(ProductSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ProductSearchErrorState(error.toString()));

    });
  }
  popStateChange(){
    emit(PopState());
  }
}