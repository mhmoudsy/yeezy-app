import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';

class HomeLayout extends StatelessWidget {
    HomeLayout({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=HomeCubit.get(context);
        return  Scaffold(
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavIndex(index);
            },
            items: cubit.items,

          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },

    );
  }
}
