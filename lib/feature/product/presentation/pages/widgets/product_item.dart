import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/core/themes/themes.dart';
import 'package:task/core/utlis/size_config.dart';
import 'package:task/core/widgets/custom_bottom_sheet.dart';
import 'package:task/core/widgets/custom_button.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({
    Key? key,
    required this.image,
    // required this.provider,
    required this.productId,
    required this.label,
    required this.description,
    required this.price,
    required this.weight,
    required this.onPressed,
  }) : super(key: key);
  final String? image;
  final String? label;
  final String? description;
  final int? productId;
  final int? price;
  final String? weight;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: image != null
                      ? FadeInImage.assetNetwork(
                          image: image!,
                          fit: BoxFit.fill,
                          placeholder: 'assets/images/about.png',
                          fadeInDuration: const Duration(seconds: 1),
                        )
                      : Image.asset('assets/images/about.png'),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(15),
                ),
                Positioned(
                    top: SizeConfig.screenHeight * 0.01,
                    left: SizeConfig.screenWidth * 0.01,
                    child: CustomBottomSheet(
                      productId: productId,
                      // provider: provider,
                    )),
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
                          ' ${double.parse(weight!).toInt().toString()} ???????? ',
                          style: TextStyle(
                              fontFamily: MainTheme.productTextFont,
                              fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Image.asset('assets/images/pounds.png'),
                        ),
                        Text('${price} ????????  ',
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
                      description!,
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
            text: '????????',
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
