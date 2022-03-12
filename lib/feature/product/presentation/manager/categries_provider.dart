import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/feature/product/data/categories_model.dart';
import 'package:task/feature/product/data/product_model.dart';

import '../../../../core/utlis/network_utils.dart';

final StateNotifierProvider<GetCategoriesNotifier, Object?> getGategoriesNotifier =
    StateNotifierProvider<GetCategoriesNotifier, Object?>(
  (ref) => GetCategoriesNotifier(),
);

class GetCategoriesNotifier extends StateNotifier<AsyncValue<CategoriesModel>> {
  GetCategoriesNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  CategoriesModel? categoriesModel;

  Future<CategoriesModel> getcategories() async {
    Response response = await _utils.requstData(
      url: 'product-categories',
      body: {},
      get: true,
    );
    if (response.statusCode == 200) {
      categoriesModel = CategoriesModel.fromJson(response.data);

      log('correct get product-categories data');
    } else {
      log('error get product-categories data');
    }
    return categoriesModel!;
  }
}
