import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/feature/product/presentation/manager/product_provider.dart';

import '../../feature/product/presentation/manager/delete_product.dart';
import '../../feature/product/presentation/pages/product_screen.dart';
import '../themes/themes.dart';
import '../utlis/helper.dart';
import '../utlis/size_config.dart';
import 'custom_button.dart';
import 'custom_new_dialog.dart';

class CustomBottomSheet extends HookConsumerWidget {
  final int? productId;

  // final ProviderBase<State> provider;

  const CustomBottomSheet({
    // required this.provider,
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomWarningDialog _dialog = CustomWarningDialog();

    return InkWell(
      child: Image.asset(
        'assets/images/more.png',
        width: SizeConfig.screenWidth * .07,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Color(0xffF9F9F9),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            builder: (_) {
              return SizedBox(
                height: SizeConfig.screenHeight * .35,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomBtn(
                        showImage: false,
                        onChange: () {},
                        elevation: 2,
                        width: SizeConfig.screenWidth,
                        backgroundColor: Colors.white,
                        height: SizeConfig.screenHeight * .075,
                        text: 'تعديل المنتج',
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: MainTheme.mainTextFont,
                        ),
                      ),
                      CustomBtn(
                        showImage: false,
                        onChange: () async {
                          return await _dialog.showOptionDialog(
                              context: context,
                              msg: 'هل ترغب بحذف المنتج ؟',
                              okFun: () async {
                                ref
                                    .read(deleteProductNotifier.notifier)
                                    .deleteProduct(productId: productId!);
                                ref.refresh(getProductNotifier);
                                pop();
                              },
                              okMsg: 'نعم',
                              cancelMsg: 'لا',
                              cancelFun: () {
                                return;
                              });
                        },
                        elevation: 2,
                        width: SizeConfig.screenWidth,
                        backgroundColor: Colors.white,
                        height: SizeConfig.screenHeight * .075,
                        text: 'حذف المنتج',
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: MainTheme.mainTextFont,
                        ),
                      ),
                      CustomBtn(
                        showImage: false,
                        onChange: () async {},
                        elevation: 2,
                        width: SizeConfig.screenWidth,
                        backgroundColor: Colors.white,
                        height: SizeConfig.screenHeight * .075,
                        text: 'نسخ المنتج',
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: MainTheme.mainTextFont,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
