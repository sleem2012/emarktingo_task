import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/core/themes/themes.dart';
import 'package:task/core/utlis/size_config.dart';
import 'package:task/core/widgets/custom_button.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.image,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * .2,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    height: SizeConfig.screenHeight * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.screenHeight * 0.01,
                  left: SizeConfig.screenWidth * 0.01,
                  child: Image.asset(
                    'assets/images/more.png',
                    width: SizeConfig.screenWidth * .07,
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.screenHeight * 0.01,
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Image.asset('assets/images/kilo.png'),
                        ),
                        Text(
                          ' 1 كيلو',
                          style: TextStyle(
                              fontFamily: MainTheme.productTextFont,
                              fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Image.asset('assets/images/pounds.png'),
                        ),
                        Text('500 جنيه  ',
                            style: TextStyle(
                                fontFamily: MainTheme.productTextFont,
                                fontSize: 12)),
                      ],
                    ),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'شنطة سفر 3 جيب',
                      style: TextStyle(
                          fontFamily: MainTheme.productTextFont,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'تيشرتات مقاس لارج خامه قطن',
                      style: TextStyle(
                          fontFamily: MainTheme.productTextFont,
                          fontWeight: FontWeight.normal,
                          fontSize: 8,
                          color: Colors.black),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Image.asset('assets/images/category.png'),
                )
              ],
            ),
          ),
          CustomBtn(
            text: 'اشحن',
            image: 'assets/images/truck.png',
            textStyle: TextStyle(
                color: Colors.lightBlueAccent,
                fontFamily: MainTheme.productTextFont),
          )
        ],
      ),
    );
  }
}
