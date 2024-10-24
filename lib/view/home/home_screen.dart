import 'package:banhang/component/main_header.dart';
import 'package:banhang/view/home/components/product_card/product_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:banhang/controller/controllers.dart';
import 'package:banhang/view/home/components/carousel_slider/carousel_loading.dart';
import 'package:banhang/view/home/components/carousel_slider/carusel_slider_view.dart';
import 'package:banhang/view/home/components/product_card/product_loading.dart';

import 'components/product_card/product_card.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Obx(() {
            if (homeController.products.isNotEmpty) {
              return CarouselSliderView(products: homeController.products);
            } else {
              return CarouselLoading();
            }
          }),
          const SizedBox(
            height: 40,
          ),
        Obx(() {
          if (!homeController.isSearch.value) {
            if(homeController.isPopular.value) {
              return const Text(
                "Sản phẩm bán chạy",
                style: TextStyle(color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              );
            }else{
              return const Text(
                "Sản phẩm cần tìm",
                style: TextStyle(color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              );
            }
        }else{
            return const Text(
              "Không tìm thấy sản phẩm",
              style: TextStyle(color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            );
          }
        }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              if (homeController.productPobulars.isNotEmpty) {
                return Expanded(
                  child: ProductListView(
                      products: homeController.productPobulars),
                );
              } else {
                return Expanded(child: ProductLoading());
              }
            }),
          ],
      ),
    );
  }
}
