import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utlis/network_utils.dart';


final StateNotifierProvider<DeleteProductNotifier, Object?> deleteProductNotifier =
StateNotifierProvider<DeleteProductNotifier, Object?>(
      (ref) => DeleteProductNotifier(null),
);

class DeleteProductNotifier extends StateNotifier<void> {
  DeleteProductNotifier(void state) : super(state);

  final NetworkUtils _utils = NetworkUtils();

  deleteProduct({required int productId}) async {
    Response response = await _utils.requstData(
      delete: true,
      url: 'products/$productId',
    );
    if (response.statusCode == 200) {
      log('product deleted');
      await Fluttertoast.showToast(
          msg: 'تم ازالة المنتج بنجاح', toastLength: Toast.LENGTH_SHORT);
    } else {
      log('error delete');
    }
  }
}
