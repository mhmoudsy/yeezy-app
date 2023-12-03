import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';

class CircleIcons extends StatelessWidget {
  String? Function() onPressed;
  IconData? icons;
  HexColor? color;
   CircleIcons({super.key,required this.onPressed,required this.icons,required this.color});


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      child: IconButton(
          onPressed: onPressed,
          icon:  Icon(icons)),
    );
  }
}
