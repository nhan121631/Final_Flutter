import 'package:banhang/component/main_header.dart';
import 'package:banhang/view/home/components/product_card/product_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:banhang/controller/controllers.dart';
import 'package:banhang/view/home/components/carousel_slider/carousel_loading.dart';
import 'package:banhang/view/home/components/carousel_slider/carusel_slider_view.dart';
import 'package:intl/intl.dart';
import '../category/components/Product_category_cart.dart';
import '../chat/chat_screen.dart';
import 'components/product_card/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _chatBallPositionX = 350; // Vị trí X của quả bóng chat
  double _chatBallPositionY = 700; // Vị trí Y của quả bóng chat

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              const MainHeader(),
              Obx(() {
                if (homeController.productPobulars.isNotEmpty) {
                  return CarouselSliderView(/*products: homeController.products*/);
                } else {
                  return CarouselLoading();
                }
              }),

              // Chuyển Obx ra ngoài điều kiện if
              Obx(() {
                return homeController.productRecommend.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Bạn có thể muốn mua",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150, // Chiều cao cố định cho ListView ngang
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeController.productRecommend.length, // Truy cập danh sách sản phẩm
                        itemBuilder: (BuildContext context, int index) {
                          final product = homeController.productRecommend[index];
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ProductCateCard(product: product), // Sử dụng `ProductCateCard` cho từng sản phẩm
                          );
                        },
                      ),
                    ),
                  ],
                )
                    : SizedBox(); // Trả về SizedBox rỗng nếu không có sản phẩm gợi ý
              }),


              const SizedBox(height: 20),
              Obx(() {
                if (!homeController.isSearch.value) {
                  if (homeController.isFilter.value) {
                    return const Text(
                      "Sản phẩm lọc theo giá",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    );
                  }

                  if (homeController.isPopular.value) {
                    return const Text(
                      "Sản phẩm bán chạy",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Text(
                      "Sản phẩm cần tìm",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    );
                  }
                } else {
                  return const Text(
                    "Không tìm thấy sản phẩm",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  );
                }
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (homeController.productPobulars.isNotEmpty) {
                  return Expanded(
                    child: ProductListView(products: homeController.productPobulars),
                  );
                } else {
                  return Expanded(child: ProductLoading());
                }
              }),
            ],
          ),

          Positioned(
            left: _chatBallPositionX,
            top: _chatBallPositionY,
            child: Draggable(
              feedback: const CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.chat, color: Colors.white),
              ),
              onDragEnd: (details) {
                setState(() {
                  // Cập nhật vị trí quả bóng chat khi người dùng thả
                  _chatBallPositionX = details.offset.dx - 30; // Điều chỉnh để căn giữa quả bóng
                  _chatBallPositionY = details.offset.dy - 30; // Điều chỉnh để căn giữa quả bóng
                });
              },
              childWhenDragging: Container(),
              child: GestureDetector(
                onTap: () {
                  // Mở ChatScreen khi ấn vào quả bóng chat
                  Get.to(() => ChatScreen());
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.chat, color: Colors.white),
                ),
              ), // Ẩn khi kéo
            ),
          ),
        ],
      ),
    );
  }
}
