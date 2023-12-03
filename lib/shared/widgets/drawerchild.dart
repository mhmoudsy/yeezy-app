import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/layouts/cubit/cubit.dart';
import 'package:yeezy_store/layouts/cubit/states.dart';
import 'package:yeezy_store/models/loginmodel.dart';
import 'package:yeezy_store/modules/accountinformation/account_information_screen.dart';
import 'package:yeezy_store/modules/carts/carts_screen.dart';
import 'package:yeezy_store/modules/login/cubit/cubit.dart';
import 'package:yeezy_store/modules/login/cubit/states.dart';
import 'package:yeezy_store/modules/login/login_screen.dart';
import 'package:yeezy_store/modules/password/changepassword.dart';
import 'package:yeezy_store/shared/constants.dart';
import 'package:yeezy_store/shared/extentions/string_extension.dart';
import 'package:yeezy_store/shared/network/local/cache_helper.dart';
import 'package:yeezy_store/shared/widgets/circle_icon.dart';
import 'package:yeezy_store/shared/widgets/drawerchildren.dart';

import '../style/NewIcons.dart';

class DrawerChild extends StatelessWidget {
  const DrawerChild({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        var cubit = HomeCubit.get(context);
        return Container(
          color: HexColor('#fdfcff'),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleIcons(
                  onPressed: () {
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  icons: NewIcons.Menu_open,
                  color: HexColor('#e7e5e5'),
                ),
                const SizedBox(
                  height: 20,
                ),
               if(cubit.userModel!=null) Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(getImage(cubit.userModel!.user!.image!)),
                      radius: 30,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cubit.userModel!.user!.userName!.capitalize(),
                            style: Theme.of(context).textTheme.titleMedium),
                        Row(
                          children: [
                            Text('Verified Profile',
                                style: TextStyle(color: Colors.grey[500])),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              NewIcons.verified,
                              color: Colors.green,
                              size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerChildren(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountInformationScreen()));
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  iconDate: NewIcons.info,
                  text: 'Account information',
                ),
                const SizedBox(
                  height: 25,
                ),
                DrawerChildren(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()));
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  iconDate: NewIcons.lock_outline,
                  text: 'Password',
                ),
                const SizedBox(
                  height: 25,
                ),
                DrawerChildren(
                  onTap: () {},
                  iconDate: NewIcons.Bag_outlined,
                  text: 'Order',
                ),
                const SizedBox(
                  height: 25,
                ),
                DrawerChildren(
                  onTap: () {},
                  iconDate: NewIcons.Wallet_outlined,
                  text: 'My Cards',
                ),
                const SizedBox(
                  height: 25,
                ),
                DrawerChildren(
                  onTap: () {},
                  iconDate: NewIcons.Heart_outlined,
                  text: 'Wishlist',
                ),
                const SizedBox(
                  height: 25,
                ),
                DrawerChildren(
                  onTap: () {},
                  iconDate: NewIcons.Settings,
                  text: 'Settings',
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 8, vertical: 15),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          CacheHelper.removeDate(key: 'token').then((value) {
                            CacheHelper.removeDate(key: 'userId');
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(NewIcons.logout),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
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
