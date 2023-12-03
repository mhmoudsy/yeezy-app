import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultMaterialButton extends StatelessWidget {
  double size;
  Color color;
  Color textColor;
  String? text;
  double height;
  double border;
  bool isTextWidget;
  Widget? widget;

  Function() onPressed;

   DefaultMaterialButton({
     super.key,
     required this.size,
      this.widget,
      this.textColor=Colors.white,
      this.height=60,
     required this.color,
      this.text,
     required this.onPressed,this.border=0,
     this.isTextWidget=true
   });


  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      height: height,
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(border) ),
      minWidth:size ,
      color: color,
      onPressed: onPressed,
      child: isTextWidget?Text(text!,
          style:
          TextStyle(color: textColor, fontSize: 18)):widget,
    );
  }
}
