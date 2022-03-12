import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/feature/product/data/product_model.dart';
import 'package:task/feature/product_details/data/product_detail_model.dart';

import '../../../../core/utlis/network_utils.dart';

final StateNotifierProvider<GetProductDetailNotifier, Object?> getProductDetailNotifier =
    StateNotifierProvider<GetProductDetailNotifier, Object?>(
  (ref) => GetProductDetailNotifier(),
);

class GetProductDetailNotifier extends StateNotifier<AsyncValue<ProductModel>> {
  GetProductDetailNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ProductDetailsModel? productDetailsModel;

  Future<ProductDetailsModel> getProductDetail({ int? productId}) async {
    Response response = await _utils.requstData(
      url: 'products/$productId',
      body: {},
      get: true,
    );
    if (response.statusCode == 200) {
      productDetailsModel = ProductDetailsModel.fromJson(response.data);

      log('correct get product detail data');
    } else {
      log('error get product detail  data');
    }
    return productDetailsModel!;
  }
}
