import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/shared/widgets/circle_icon.dart';

import '../constants.dart';
import '../style/NewIcons.dart';

class AppBarWidget extends StatelessWidget {
  String? Function() firstOnPressed;
  IconData firstCircleIcon;
  HexColor firstCircleColor;
  String? Function()? lastOnPressed;
  IconData? lastCircleIcon;
  HexColor? lastCircleColor;
  bool isThereCenter;
  Widget? centerWidget;
  Widget? lastButton;
  bool isThereLast;
  bool thereIsButtonAtLast;
  bool isBadge;
  Widget? badgeWidget;

  AppBarWidget({
    super.key,
    this.isThereCenter=false,
    this.isThereLast=false,
    this.thereIsButtonAtLast=false,
    this.isBadge=false,
    this.centerWidget,
    this.badgeWidget,
    this.lastButton,
    required this.firstOnPressed,
    required this.firstCircleIcon,
    required this.firstCircleColor,
     this.lastOnPressed,
     this.lastCircleIcon,
     this.lastCircleColor,
   });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIcons(
          onPressed:firstOnPressed,
          icons: firstCircleIcon,
          color: firstCircleColor,
        ),
        const Spacer(),
        if(isThereCenter)centerWidget!,
        if(isThereCenter&&!isThereLast)SizedBox(width: 8,),
        if(isThereCenter) const Spacer(),

        if(isBadge)Badge(
          label: badgeWidget,
          child:CircleIcons(
            onPressed: lastOnPressed!,
            icons: lastCircleIcon,
            color: lastCircleColor,
          ),
        ),
        if(isThereLast)CircleIcons(
          onPressed: lastOnPressed!,
          icons: lastCircleIcon,
          color: lastCircleColor,
        ),
        if(thereIsButtonAtLast)lastButton!,
      ],
    );
  }
}
