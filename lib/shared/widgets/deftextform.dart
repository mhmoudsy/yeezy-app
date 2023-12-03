import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../style/NewIcons.dart';

class DefTextForm extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?) validator;
  String? Function(String?)? onChange;
  String? Function()? onTap;
  TextInputType textInputType;
  bool isObscure;
  bool readOnly;
  bool filled;
  double borderRadius;
  double contentPadding;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Color borderColor;
  Color colorFill;
  int scrollPadding;
  double borderWidth;
  TextInputAction? textInputAction;
  Widget? label;
  String? hintText;
  DefTextForm({
    super.key,
    required this.controller,
    required this.validator,
    required this.textInputType,
     this.label,
     this.scrollPadding=0,
    this.onChange,
    this.onTap,
    this.isObscure = false,
    this.readOnly = false,
    this.filled = false,
    this.borderRadius = 18,
    this.contentPadding = 15,
    this.borderColor = Colors.black,
    this.colorFill = Colors.white,
    this.borderWidth = 0.3,
    this.prefixIcon,
    this.hintText,
    this.textInputAction,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      validator: validator,
      keyboardType: textInputType,
      onChanged: onChange,
      obscureText: isObscure,
      onTap: onTap,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onTapOutside: (event){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+scrollPadding),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        contentPadding: EdgeInsets.all(contentPadding),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        hintText: hintText,

        filled: filled,
        fillColor: colorFill,
        label: label,
      ),
    );
  }
}
