import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/home_layout.dart';
import 'package:yeezy_store/modules/login/login_screen.dart';
import 'package:yeezy_store/shared/bloc_observer.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/network/local/cache_helper.dart';
import 'package:yeezy_store/shared/network/remote/dio_helper.dart';
import 'package:yeezy_store/shared/stripekey.dart';

import 'modules/search/cubit/cubit.dart';

void main() async {
  Stripe.publishableKey=StripeKey.publishableKey;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  token=CacheHelper.getDate(key: 'token');
  currentUserId=CacheHelper.getDate(key: 'userId');
  print(currentUserId);
  print(token);
  Widget? widget;
  if(token !=null){
    widget=HomeLayout();
  }else{
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;
   MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>HomeCubit()..getCategory()..getProduct()..getSize()..getProductReview()..getFavorites()..getCarts()..getUserData()..getOwnOrder()),
        BlocProvider(create: (context)=>SearchCubit()),
      ], child:MaterialApp(

      title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent,
              elevation: 0.0,


            ),

          ),
          home: widget,
          debugShowCheckedModeBanner: false,
        ) ,

    );
  }
}
