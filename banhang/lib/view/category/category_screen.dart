import 'package:banhang/component/main_header.dart';
import 'package:banhang/controller/controllers.dart'; // Ensure this includes your CategoryController
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/category_body.dart';
import 'components/product_category_loading.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Obx(() {
            return categoryController.categories.isNotEmpty
                ? CategoryProductList(categories: categoryController.categories)
                : ProductCateLoading();
          }),
        ],
      ),
    );
  }
}
