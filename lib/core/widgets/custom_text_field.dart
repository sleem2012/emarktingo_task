import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/core/utlis/size_config.dart';

import '../themes/themes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.hintTextNoLocal,
    this.keyboardType,
    this.obsecureText = false,
    this.controller,
    this.validator,
    this.enableText = true,
    this.isDetails = false,
    this.formatter,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    this.verticalPadding,
    this.horizontalMargin,
    this.globalKey,
    this.maxLines = 1,
    this.fontSize,
    this.onChange, this.onTap, this.focusNode, this.boxWidth,
  }) : super(key: key);

  final String? hintText, labelText;
  final String? hintTextNoLocal;
  final List<TextInputFormatter>? formatter;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final ValueChanged<String>? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? enableText;
  final Widget? suffixIcon;
  final bool isDetails;
  final bool? filled;
  final Color? fillColor;
  final FocusNode? focusNode;
  final double? verticalPadding;
  final double? horizontalMargin;
  final Key? globalKey;
  final int? maxLines;
  final double? fontSize;
  final double? boxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: horizontalMargin ?? 15, vertical: 5),
      child: SizedBox(
        width: boxWidth,
        child: TextFormField(
onTap: onTap,
          key: globalKey,
          onChanged: onChange,
          inputFormatters: formatter,
          maxLines: isDetails ? null : 1,
          enabled: enableText,
          controller: controller,
          validator: validator,
          obscureText: obsecureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.transparent,
            filled: filled,
            labelText: labelText,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.screenHeight * (verticalPadding ?? 0.022),
                horizontal: SizeConfig.screenWidth * 0.02),
            suffixIcon: suffixIcon,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 25,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:  BorderSide(
                color: Colors.grey.shade200,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Color(0xffF5F5F5),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Color(0xffF5F5F5),
                width: 4,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).errorColor,
              ),
            ),
            // filled: true,
            // fillColor: Colors.grey[200],
            hintText: hintText,

            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: fontSize,
              fontFamily: MainTheme.productTextFont,
            ),
          ),
        ),
      ),
    );
  }
}
