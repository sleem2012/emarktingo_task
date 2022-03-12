import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:task/core/themes/screen_utility.dart';
import 'package:task/core/themes/themes.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/feature/add_product/presentation/pages/add_product_screen.dart';
import 'package:task/feature/product/data/categories_model.dart';
import 'package:task/feature/product/data/product_model.dart';
import 'package:task/feature/product/presentation/pages/widgets/product_item.dart';
import 'package:task/core/utlis/helper.dart';
import 'package:task/feature/product_details/presentation/manager/product_detail_provider.dart';
import '../manager/categries_provider.dart';
import '../manager/product_provider.dart';
import 'package:task/feature/product_details/presentation/pages/product_detail_screen.dart';

import '../../../../core/utlis/size_config.dart';

class ProductScreen extends HookConsumerWidget {
  ProductScreen({Key? key}) : super(key: key);

  final AutoDisposeFutureProvider<ProductModel> provider =
      FutureProvider.autoDispose<ProductModel>((ref) async {
    return await ref
        .watch(getProductNotifier.notifier)
        .getProduct(); // may cause `provider` to rebuild
  });


  StateProvider<List<Data>> suggestionsProvider =
      StateProvider<List<Data>>((ref) => []);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Data> suggestions = ref.watch(suggestionsProvider);

    ScrollController scrollController = ScrollController();
    SizeConfig().init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: ref.watch(provider).when(
              loading: () => const SpinKitWave(
                color: MainStyle.secondColor,
              ),
              error: (e, o) {
                debugPrint(e.toString());
                debugPrint(o.toString());
                return const Text('error');
              },
              data: (e) => Scaffold(
                backgroundColor: Colors.white,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    push( AddProductScreen());
                  },
                  child: const Icon(Icons.add),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    SizedBox(
                      width: SizeConfig.screenWidth * .6,
                      child: CustomTextField(
                        hintText: 'ابحث في منتجك',
                        fontSize: 15,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        onChange: (v) {
                          ref.read(suggestionsProvider.state).state = [
                            ...e.data!
                                .where(
                                  (element) => element.name!
                                      .startsWith(v.toLowerCase().trim()),
                                )
                                .toList()
                          ];
                          debugPrint('ll' + suggestions.toString());
                          debugPrint('ll' + e.data!.toString());
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.black,
                    ),
                  ],
                  elevation: 0,
                  title: Text(
                    'المنتجات',
                    style: TextStyle(
                        fontFamily: MainTheme.productTextFont,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: (e.data!.isEmpty && suggestions.isEmpty)
                        ? Center(
                            child: Lottie.asset(
                              'assets/images/noData.json',
                              repeat: false,
                            ),
                          )
                        : GridView.builder(
                            itemCount: suggestions.isNotEmpty
                                ? suggestions.length
                                : e.data!.length,
                            itemBuilder: (context, index) => ProductItem(
                              productId: suggestions.isNotEmpty
                                  ? suggestions[index].id
                                  : e.data![index].id,
                              // provider: provider,
                              onPressed: () {
                                push(ProductDetailsScreen(
                                  productId: suggestions.isNotEmpty
                                      ? suggestions[index].id
                                      : e.data![index].id,
                                ));
                              },
                              image: suggestions.isNotEmpty
                                  ? suggestions[index].image
                                  : e.data![index].image,
                              label: suggestions.isNotEmpty
                                  ? suggestions[index].name
                                  : e.data![index].name,
                              description: suggestions.isNotEmpty
                                  ? suggestions[index].description
                                  : e.data![index].description,
                              price: suggestions.isNotEmpty
                                  ? suggestions[index].price
                                  : e.data![index].price,
                              weight: suggestions.isNotEmpty
                                  ? suggestions[index].weight
                                  : e.data![index].weight,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 15,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 10,
                              childAspectRatio: .6,
                              // mainAxisExtent: context.height * 0.13,
                            ),
                          ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
