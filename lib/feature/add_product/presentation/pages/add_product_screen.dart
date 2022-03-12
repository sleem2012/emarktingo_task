import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:task/core/themes/screen_utility.dart';
import 'package:task/core/utlis/helper.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/core/widgets/madal_bottom_sheet.dart';
import 'package:task/feature/add_product/presentation/manager/add_product_provider.dart';
import 'package:task/feature/product/presentation/pages/product_screen.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utlis/image_picker_dialog.dart';
import '../../../../core/utlis/size_config.dart';
import '../../../product/data/categories_model.dart';
import '../../../product/presentation/manager/categries_provider.dart';
import '../../data/add_product_model.dart';

class AddProductScreen extends HookConsumerWidget {
  AddProductScreen({Key? key}) : super(key: key);

  final FutureProvider<CategoriesModel> provider2 =
  FutureProvider<CategoriesModel>((ref) async {
    return await ref
        .watch(getGategoriesNotifier.notifier)
        .getcategories(); // may cause `provider` to rebuild
  });
  final StateProvider<File> imagePickerProvider =
  StateProvider<File>((ref) => File(''));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProgressDialog pd = ProgressDialog(context: context);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    File imagePicker = ref.watch(imagePickerProvider);
    AddProductNotifier addProduct = ref.read(addProductNotifier.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: imagePicker.path != ''
              ? Image.file(
            imagePicker,
            fit: BoxFit.fill,
          )
              : Image.asset('assets/images/fullpic.png', fit: BoxFit.fill),
        ),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * .05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: SizeConfig.screenHeight * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(width: 1, color: Colors.grey.shade200),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'صورة المنتج',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: MainTheme.productTextFont,
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: imagePicker.path != ''
                              ? FileImage(imagePicker)
                              : const AssetImage('assets/images/fullpic.png')
                          as ImageProvider,
                          child: GestureDetector(
                              onTap: () async {
                                await ImagePickerDialog().show(
                                    context: context,
                                    onGet: (f) =>
                                    {
                                      ref
                                          .read(imagePickerProvider.state)
                                          .state = f
                                    });
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                CustomTextField(
                  onChange: (v) async {
                    addProduct.name = v;
                  },
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'اسم المنتج',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'ادخل اسم المنتج';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                CustomTextField(
                    onChange: (v) {
                      addProduct.description = v;
                      // debugPrint(ref.watch(addProductNotifier.notifier).imageModel!.path.toString());
                    },
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'مواصفات المنتج',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل مواصفات المنتج';
                      }
                      return null;
                    }),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * .035),
                  child: ref.watch(provider2).when(
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
                        ModalBottomSheet(
                            onChange: (v) {
                              debugPrint(v.toString());
                              addProduct.categoryId = v;
                            },
                            name: 'نوع المنتج',
                            list: ref
                                .watch(getGategoriesNotifier.notifier)
                                .categoriesModel!
                                .data!),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                CustomTextField(
                    onChange: (v) {
                      addProduct.price = int.parse(v);
                    },
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'سعر المنتج',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل سعر المنتج';
                      }
                      return null;
                    }),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.screenWidth * .027),
                  child: Container(
                    height: SizeConfig.screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const ImageIcon(AssetImage('assets/images/size.png')),
                        Text(
                          'حجم المنتج',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: MainTheme.productTextFont,
                          ),
                        ),
                        Text(
                          'الطول  * العرض  * الارتفاع',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: MainTheme.productTextFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(
                        onChange: (v) {
                          addProduct.height = int.parse(v);
                        },
                        boxWidth: SizeConfig.screenWidth * .2,
                        horizontalMargin: 10,
                        filled: true,
                        keyboardType: TextInputType.number,
                        fillColor: Colors.grey[200],
                        hintText: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ادخل طول المنتج';
                          }
                          return null;
                        }),
                    const Text(
                      '*',
                      style: TextStyle(fontSize: 20),
                    ),
                    CustomTextField(
                        onChange: (v) {
                          addProduct.width = int.parse(v);
                        },
                        keyboardType: TextInputType.number,
                        boxWidth: SizeConfig.screenWidth * .2,
                        horizontalMargin: 10,
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ادخل عرض المنتج';
                          }
                          return null;
                        }),
                    const Text(
                      '*',
                      style: TextStyle(fontSize: 20),
                    ),
                    CustomTextField(
                        onChange: (v) {
                          addProduct.length = int.parse(v);
                        },
                        keyboardType: TextInputType.number,
                        boxWidth: SizeConfig.screenWidth * .2,
                        horizontalMargin: 10,
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ادخل ارتفاع المنتج';
                          }
                          return null;
                        }),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Row(
                  children: [
                    CustomTextField(
                      boxWidth: SizeConfig.screenWidth * .3,
                      enableText: false,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '    وزن المنتج',
                    ),
                    CustomTextField(
                        onChange: (v) {
                          addProduct.weight = int.parse(v);
                        },
                        boxWidth: SizeConfig.screenWidth * .5,
                        filled: true,
                        keyboardType: TextInputType.number,
                        fillColor: Colors.grey.shade100,
                        hintText: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ادخل وزن المنتج';
                          }
                          return null;
                        }),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * .3),
                  child: CustomBtn(
                    showImage: false,
                    backgroundColor: const Color(0xff0062DD),
                    onChange: () async {
                      if (_formKey.currentState!.validate()) {
                        final bytes = imagePicker.readAsBytesSync();
                        String _img64 = base64Encode(bytes);
                        await addProduct.uploadPhoto(
                          _img64,
                          context,
                          "${DateTime.now().toString().substring(0, 10)}+.png",
                        );
                        pd.show(max: 100, msg: 'loading progress');

                        await Future.delayed(
                          const Duration(seconds: 3),
                        ).whenComplete(() async {
                          // debugPrint(addProduct.imageModel!.path);

                          addProduct
                              .addProduct(
                              context: context,
                              path: addProduct.imageModel!.path!)
                              .then((value) {
                            pd.close();
                            pushAndRemoveUntil(ProductScreen());
                          }
                          );
                        });
                      }
                    },
                    text: 'اضافة المنتج',
                    height: SizeConfig.screenHeight * .07,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: MainTheme.productTextFont,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .05,
                )
              ],
            ),
          )),
    );
  }
}
