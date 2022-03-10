import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/core/themes/themes.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/feature/product/presentation/pages/widgets/product_item.dart';

import '../../../../core/utlis/size_config.dart';

class ProductScreen extends StatelessWidget {
   ProductScreen({Key? key}) : super(key: key);
  List<dynamic> productItem = [
    {
      'image': 'assets/images/grid.png',
      'label': 'add_new_product',
    },

  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
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
                  onChange: (String v) {},
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.black,
              ),
            ],
            elevation: 0,
            title:  Text(
              'المنتجات',
              style: TextStyle(
                fontFamily: MainTheme.productTextFont,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: SizeConfig.screenHeight,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder: (context, index) => ProductItem(
                  onPressed: () {
                    // N.to(
                    //   AddNewProductScreen(),
                    // );
                  },
                  image: productItem[0]['image'],
                  label: productItem[0]['label'],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
