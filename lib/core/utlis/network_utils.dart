import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkUtils {
  NetworkUtils();

  final baseUrl = 'http://weevo.emarketingo.org/api/v1/merchant/';
  Dio dio = Dio();
  Response? response;
  final Map<String, String> _headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MTZkY2NlNC0yZjI5LTQ4MjgtOGQ0Yi0wOTdhZjg5Nzk2ZTciLCJqdGkiOiJiMjkyZjM3YjI2Yzk3YWE0YTU1MDBkOWFkYzNmODViMmI1MTA4MGVhZWI2MzBkMWQ4ZjQxM2IzMmYwYWE2YTIzOTY0ZDM0NTMxOGYxYjFkMyIsImlhdCI6MTY0NjkzMzA4Mi40MzE4MDIsIm5iZiI6MTY0NjkzMzA4Mi40MzE4MDgsImV4cCI6MTY3ODQ2OTA4Mi40Mjc3ODksInN1YiI6IjMiLCJzY29wZXMiOltdfQ.ekDKd_EH4o2qb1Ek-0J1INaU182hn8n-HhFNue9XdXqMGZtTqFL6v0qhij2KxvEsF-ECLU5DzViyEDc4kri6bSfe4KmUrsmA4HVFqL8MeBsSUn63srznyBpvI8r4CqAUx84nqYFgBufs3eVXMppLJbEEf_TRBta2PDRBlMlM-6J3pzxSs8PYMytlyhjbcBAyEscrS-qsuWyk8k7-w-KhrehXBTr7e94Ht4dpmdzh4Cw1sPGukNNjvkFPboedI3i-ysbjjLLce4qDCDKXLY1SfLQJNkcvo-RNcPg9v0mK-sapC-D5u3dcw8YNoyJ0xh6382ekXbS1yy2d_Ovzi897wLiwfxIwXppnsvU6173AbAcezz4p9ilENa5BicInvmoxI472u0dAhn7w5aHhheDPClEL-NhBdyvNRp-9HMafr3CAwHB4n_I_up-O1l9IazN0BBLOcnVhXVQ2ykBGjKABgpRs8_p4v5idRcVlm-v2NKdcH4stXLIDJdDqd7CixEihjRwHkkuzQE5z7ybMmPJE2hesm1y83L9mqBw7WYZFeFxCGWHuTeoQpfwpZWMY82NXDEVwahYxO-_WRFtuumDOGTLG5QQnqm9kvF5CgrUzr_KxrOHlINX2dEpngizfo1S1PHxN7pp8BAN9WQ50XiBwtoANQHPD07EnG0_TFNDEwyA',
  };

  Future<Response> requstData({
    required String url,
    dynamic body,
    bool? get,
    bool? delete,
    bool? put,
  }) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };
    try {
      // if (GetStorage().read(kIsLoggedIn) == true) {
      //   _headers.addAll({
      //     'Authorization': 'Bearer ${GetStorage().read(kToken)}',
      //   });
      // }
      if (get == true) {
        response =
            await dio.get(baseUrl + url, options: Options(headers: _headers));
      } else if (delete == true) {
        response = await dio.delete(
          baseUrl + url,
          data: body,
          options: Options(headers: _headers),


        );
      } else if (put == true) {
        response = await dio.put(
          baseUrl + url,
          data: body,
          options: Options(headers: _headers),
          onSendProgress: (int sent, int total) {
            final progress = sent / total;
            debugPrint('progress: $progress ($sent/$total)');
          },
        );
      }else {
        response = await dio.post(
          baseUrl + url,
          data: body,
          options: Options(headers: _headers),
          onSendProgress: (int sent, int total) {
            final progress = sent / total;
            debugPrint('progress: $progress ($sent/$total)');
          },
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        debugPrint('response: ' + e.response.toString());
      } else {}
    }
    return handleResponse(response!);
  }

  Future<Response> handleResponse(
    Response response,
  ) async {
    String message = '';
    if (response.data.runtimeType == String) {
      if (response.data != null) {
        String body = response.data;
        var jsonObject = jsonDecode(body);
        message = jsonObject['message'];
        Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
      }
      return Response(
          statusCode: 102,
          data: {
            'mainCode': 0,
            'code': 102,
            'data': null,
            'error': [
              {'key': 'internet', 'value': 'هناك خطا يرجي اعادة المحاولة'}
            ]
          },
          requestOptions: RequestOptions(path: ''));
    } else {
      final int statusCode = response.statusCode!;
      log('response: ' + response.toString());
      log('statusCode: ' + statusCode.toString());
      if (statusCode == 200 && statusCode < 300) {
        return response;
      }
      //  else if (statusCode == 400) {
      //   Fluttertoast.showToast(
      //       msg: loginData!.message!, toastLength: Toast.LENGTH_SHORT);
      //   return response;
      // } else if (statusCode == 401) {
      //   UserModel user = UserModel.fromJson(response.data);
      //   await GetStorage.init().then((value) async {
      //     await GetStorage().remove(kcashedUserData);
      //     await GetStorage().remove(kIsLoggedIn);
      //   });
      //   loginData = null;

      //   Fluttertoast.showToast(
      //       msg: user.message!, toastLength: Toast.LENGTH_SHORT);
      //   pushAndRemoveUntil(const SplashView());
      //   return response;
      // }
      else if (statusCode <= 500) {
        Fluttertoast.showToast(
            msg: 'يرجي التحقق من الاتصال بالانترنت',
            toastLength: Toast.LENGTH_SHORT);
        return Response(
            statusCode: 500,
            data: {
              'mainCode': 0,
              'code': 500,
              'data': null,
              'error': [
                {'key': 'internet', 'value': 'يرجي التحقق من الاتصال بالانترنت'}
              ]
            },
            requestOptions: RequestOptions(path: ''));
      } else {
        return response;
      }
    }
  }
}
