import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/core/themes/screen_utility.dart';

import '../themes/themes.dart';
import '../utlis/size_config.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final String? image;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final void Function() onChange;
  final Color? backgroundColor;
  final bool showImage;
  final double? elevation;

  const CustomBtn(
      {Key? key,
      required this.text,
      this.height,
      this.width,
      this.elevation,
      this.image,
      this.textStyle,
      required this.onChange,
      this.backgroundColor,
      required this.showImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? SizeConfig.screenHeight * 0.06,
      width: width ?? SizeConfig.screenWidth * 0.4,
      child: MaterialButton(
        onPressed: onChange,
        color: backgroundColor ?? Colors.blue[100],
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              if (showImage)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(image!),
                )
            ],
          ),
        ),
      ),
    );
  }
}
