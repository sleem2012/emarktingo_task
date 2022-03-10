import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/utlis/helper.dart';
import 'core/utlis/size_config.dart';
import 'feature/product/presentation/pages/product_screen.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() async{
      WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
     
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task',
        navigatorKey: navigator,

        home: ProductScreen(),
      ),
    );
  }
}
