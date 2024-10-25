import 'package:banhang/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Product_category_cart.dart';

class CategoryProductList extends StatelessWidget {
  final List<Category> categories;

  const CategoryProductList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: categories.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8.0, bottom: 8.0), // Thêm khoảng cách bên trái
                  child: Text(
                    categories[index].name,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),

                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories[index].products.length, // Truy cập danh sách sản phẩm
                    itemBuilder: (BuildContext context, int productIndex) {
                      return /*Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.amber[300],
                        child: Center(
                          child: Text(categories[index].products[productIndex].name), // Truy cập sản phẩm
                        ),
                      );*/
                        ProductCateCard(product:categories[index].products[productIndex]);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}