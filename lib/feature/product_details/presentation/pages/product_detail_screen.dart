import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/core/themes/screen_utility.dart';
import 'package:task/core/themes/themes.dart';
import 'package:task/core/utlis/helper.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/feature/product/presentation/manager/delete_product.dart';
import 'package:task/feature/product_details/data/product_detail_model.dart';
import 'package:task/feature/product_details/presentation/manager/product_detail_provider.dart';

import '../../../../core/utlis/size_config.dart';
import '../../../../core/widgets/custom_new_dialog.dart';
import '../../../product/presentation/pages/product_screen.dart';

class ProductDetailsScreen extends HookConsumerWidget {
  ProductDetailsScreen({
    required this.productId,
    Key? key,
  }) : super(key: key);

  final int? productId;
  final AutoDisposeFutureProviderFamily<ProductDetailsModel, int> provider =
  FutureProvider.family.autoDispose<ProductDetailsModel, int>((ref, id) async {
    return await ref
        .read(getProductDetailNotifier.notifier)
        .getProductDetail(productId: id); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomWarningDialog _dialog = CustomWarningDialog();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffFBFBFB),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                    onTap: () {
                      pop();
                    },
                    child: Image.asset(
                      'assets/images/arrowback.png',
                    ))),
            elevation: 0,
            // title: Text(
            //   'منتج رقم 5',
            //   style: TextStyle(
            //     fontFamily: MainTheme.productTextFont,
            //     color: Colors.black,
            //   ),
            // ),
          ),
          body: ref.watch(provider(productId!)).when(
            loading: () =>
            const SpinKitWave(
              color: MainStyle.secondColor,
            ),
            error: (e, o) {
              debugPrint(e.toString());
              debugPrint(o.toString());
              return const Text('error');
            },
            data: (e) =>
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * .03),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: SizeConfig.screenHeight,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * .38,
                            width: SizeConfig.screenWidth,
                            child: ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                e.image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          SizedBox(
                            height: SizeConfig.screenHeight * .12,
                            child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .04,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.name!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: MainTheme
                                                  .mainTextFont,
                                              letterSpacing: 5),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          e.description!,
                                          style: TextStyle(
                                              fontFamily: MainTheme
                                                  .mainTextFont,
                                              letterSpacing: 3,
                                              fontSize: 9,
                                              color: const Color(0xff858585)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .3,
                                    ),
                                    Image.asset(
                                      'assets/images/category.png',
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * .1,
                            child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .04,
                                    ),
                                    const ImageIcon(
                                        AssetImage('assets/images/size.png')),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text(double.parse(e.length!).toInt().toString()),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text('*'),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text(double.parse(e.width!).toInt().toString()),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text('*'),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text(double.parse(e.height!).toInt().toString()),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * .1,
                            child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .04,
                                    ),
                                    const ImageIcon(
                                        AssetImage('assets/images/kilo2.png')),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text(
                                      '${double.parse(e.weight!).toInt().toString()}   كيلو جرام',
                                      style: TextStyle(
                                          fontFamily: MainTheme.mainTextFont,
                                          fontSize: 12),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * .1,
                            child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .04,
                                    ),
                                    const ImageIcon(
                                        AssetImage('assets/images/pound.png')),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * .03,
                                    ),
                                    Text(
                                      '${e.price}  جنيه',
                                      style: TextStyle(
                                          fontFamily: MainTheme.mainTextFont,
                                          fontSize: 12),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * .02,
                          ),
                          CustomBtn(
                            showImage: true,
                            onChange: () {},
                            backgroundColor: MainStyle.secondColor,
                            height: SizeConfig.screenHeight * .075,
                            width: SizeConfig.screenWidth,
                            text: 'اشحن المنتج',
                            image: 'assets/images/wtruck.png',
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: MainTheme.mainTextFont,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomBtn(
                                showImage: false,
                                onChange: () {},
                                backgroundColor: const Color(0xffC2C2C2),
                                height: SizeConfig.screenHeight * .075,
                                width: SizeConfig.screenWidth / 2.3,
                                text: 'تعديل المنتج',
                                image: 'assets/images/wtruck.png',
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: MainTheme.mainTextFont,
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * .07,
                              ),
                              CustomBtn(
                                showImage: false,
                                onChange: ()async {
                                  return await _dialog.showOptionDialog(
                                      context: context,
                                      msg: 'هل ترغب بحذف المنتج ؟',
                                      okFun: () async {
                                        ref.read(deleteProductNotifier.notifier)
                                            .deleteProduct(productId: productId!);
                                        pushAndRemoveUntil(ProductScreen());
                                      },
                                      okMsg: 'نعم',
                                      cancelMsg: 'لا',
                                      cancelFun: () {
                                        return;
                                      });

                                },
                                width: SizeConfig.screenWidth / 2.3,
                                backgroundColor: const Color(0xffFF4040),
                                height: SizeConfig.screenHeight * .075,
                                text: 'مسح المنتج',
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: MainTheme.mainTextFont,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
