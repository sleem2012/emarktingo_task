// import 'dart:developer';
// import 'package:dio/dio.dart';
// import '../../../../core/network_utils.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../../layest_model/layest_model.dart';
//
// class GetArchiveNotifier extends StateNotifier<AsyncValue<LayestModel>> {
//   GetArchiveNotifier() : super(const AsyncValue.loading());
//   final NetworkUtils _utils = NetworkUtils();
//
//   List<LayestModel> orders = [];
//
//   Future<List<LayestModel>> getArchives() async {
//     Response response =
//         await _utils.requstData(url: 'api.php?latest', get: true);
//     if (response.statusCode == 200) {
//       response.data.forEach(
//         (element) {
//           orders.add(LayestModel.fromJson(element));
//         },
//       );
//       log('correct get Archive data');
//     } else {
//       log('error get Archive data');
//     }
//     return orders.reversed.toList();
//   }
// }
