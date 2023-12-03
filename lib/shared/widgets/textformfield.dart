import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultTextForm extends StatelessWidget {
  TextEditingController controller;
   String? Function(String?) validate;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  bool? filled=false;
  String? hintText='';
  final void Function()? onTap;
  Color? fillColor=Colors.white;
  Color? borderColor=Colors.white;
  final bool isSecure;
  final bool? isEnabled;

   DefaultTextForm({
     super.key,
      required this.controller,
     required this.validate,
      this.prefixIcon,
      this.suffixIcon,
      this.filled,
     required this.hintText,
      this.fillColor,
      this.borderColor,
     this.onTap,
     this.isEnabled,
     this.textInputType,
     this.textInputAction,
     this.isSecure=false,



   });


  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      validator: validate,
      enabled: isEnabled,
      obscureText:isSecure ,
      onTap: onTap,
      textInputAction:textInputAction ,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: filled,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
            vertical: 10
        ),
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: borderColor!,
            )

        ),

      ),
    );
  }
}
