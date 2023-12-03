import 'package:flutter/material.dart';
import 'package:yeezy_store/shared/style/NewIcons.dart';

class DrawerChildren extends StatelessWidget {
  String? Function() onTap;
  IconData? iconDate;
  String? text;

  DrawerChildren({super.key,required this.onTap,required this.iconDate,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap:onTap,
        child: Row(
          children: [
            Icon(iconDate),
            SizedBox(width: 5,),
            Text(text!,style: TextStyle(

            ),),
          ],
        ),
      ),
    );
  }
}
