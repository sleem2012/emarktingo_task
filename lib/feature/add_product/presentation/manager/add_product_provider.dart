import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:task/feature/add_product/data/Image_model.dart';
import 'package:task/feature/add_product/data/add_product_model.dart';
import 'package:task/feature/product/presentation/pages/product_screen.dart';

import '../../../../core/utlis/helper.dart';
import '../../../../core/utlis/network_utils.dart';

final StateNotifierProvider<AddProductNotifier, Object?> addProductNotifier =
    StateNotifierProvider(
  (ref) => AddProductNotifier(null),
);

class AddProductNotifier extends StateNotifier<void> {
  AddProductNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();
  AddProductModel? addProductModel;
  ImageModel? imageModel;

  String? name, description;
  int? categoryId, height, length, weight, merchantId, width, price;

  Future<AddProductModel?> addProduct(
      {required BuildContext context, required String path}) async {
    Response response = await _utils.requstData(
      body: FormData.fromMap(
        {
          'name': name,
          'description': description,
          'category_id': categoryId,
          'price': price,
          'length': length,
          'width': width,
          "height": height,
          "weight": weight,
          "merchant_id": 3,
          'image': "http://weevo.emarketingo.org$path",
        },
      ),
      url: 'products',
    );

    if (response.statusCode! <= 300) {
      // addProductModel = AddProductModel.fromJson(response.data);


    } else {
      debugPrint('add failed');

      // HelperFunctions.errorBar(context, message: 'خطا ف اضافه العميل');
    }
    return addProductModel;
  }

  Future<ImageModel> uploadPhoto(
      String image, BuildContext context, String fileName) async {
    ProgressDialog pd = ProgressDialog(context: context);
    // pd.show(max: 50, msg: 'loading progress');
    Response response = await _utils.requstData(
      url: 'products/upload-image',
      body: {'filename': fileName, 'file': image},
    );
    if (response.statusCode == 200) {
      imageModel = ImageModel.fromJson(response.data);
      // pd.close();
      debugPrint('succes image');
    } else {
      debugPrint('failed image');
    }
    return imageModel!;
  }
}
