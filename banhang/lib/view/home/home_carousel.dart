import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:banhang/controller/home_controller.dart';
import 'package:banhang/model/products_model.dart';

class HomeCarousel extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return CarouselSlider.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index, realIndex) {
          Product product = controller.products[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(product.thumbnail,
                    fit: BoxFit.cover), // Hình ảnh sản phẩm
                SizedBox(height: 10),
                Text(product.name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Price: \$${product.sellPrice}',
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          onPageChanged: (index, reason) {
            // Xử lý sự kiện khi trang được thay đổi nếu cần
          },
        ),
      );
    });
  }
}
