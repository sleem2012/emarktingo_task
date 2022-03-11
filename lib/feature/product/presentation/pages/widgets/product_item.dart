import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/core/themes/themes.dart';
import 'package:task/core/utlis/size_config.dart';
import 'package:task/core/widgets/custom_bottom_sheet.dart';
import 'package:task/core/widgets/custom_button.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem( {
    Key? key,
    required this.image,
    // required this.provider,
    required this.productId,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final String? image;
  final String? label;
  final int? productId;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
                ClipRRect(
                  child: Image.network(
                    image!,
                    fit: BoxFit.fill,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(15),
                ),
                Positioned(
                  top: SizeConfig.screenHeight * 0.01,
                  left: SizeConfig.screenWidth * 0.01,
                  child:  CustomBottomSheet(productId:productId ,
                    // provider: provider,
                  )
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
            height: SizeConfig.screenHeight * .06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label!,
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
                          fontSize: 9,
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
            showImage: true,
            onChange: () {},
            text: 'اشحن',
            image: 'assets/images/truck.png',
            textStyle: TextStyle(
              color: const Color(0xff0062DD),
              fontFamily: MainTheme.productTextFont,
            ),
          )
        ],
      ),
    );
  }
}
