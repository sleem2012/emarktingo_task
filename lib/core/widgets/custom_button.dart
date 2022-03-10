
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';
import '../utlis/size_config.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final String? image;
  final double? height;
  final double? width;
  final TextStyle? textStyle;

  const CustomBtn({
    Key? key,
    required this.text, this.height, this.width, this.image, this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??SizeConfig.screenHeight * 0.06,
      width: width??SizeConfig.screenWidth * 0.4,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.blue[100],
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              Image.asset(image!),
            ],
          ),
        ),
      ),
    );
  }
}
