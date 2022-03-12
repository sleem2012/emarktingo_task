import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/feature/product/data/product_model.dart';

import '../../../../core/utlis/network_utils.dart';

final AutoDisposeStateNotifierProvider<GetProductNotifier, Object?> getProductNotifier =
    StateNotifierProvider.autoDispose<GetProductNotifier, Object?>(
  (ref) => GetProductNotifier(),
);

class GetProductNotifier extends StateNotifier<AsyncValue<ProductModel>> {
  GetProductNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ProductModel? productModel;

  Future<ProductModel> getProduct() async {
    Response response = await _utils.requstData(
      url: 'products',
      body: {},
      get: true,
    );
    if (response.statusCode == 200) {
      productModel = ProductModel.fromJson(response.data);

      log('correct get product data');
    } else {
      log('error get data');
    }
    return productModel!;
  }
}
