import 'package:badges/badges.dart';
import 'package:banhang/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);
  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(0, 0),
                    blurRadius: 8,
                  )
                ],
              ),
              child: TextField(
                autofocus: false,
                onSubmitted: (val) {
                  homeController.getProductSearch(val);
                },
                onChanged: (val) {
                  homeController.getProductSearch(val);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              _showFilterDialog(context);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<int>(
            valueListenable: cartController.itemCart,
            builder: (context, itemCount, child) {
              return badges.Badge(
                badgeContent: Text(
                  "$itemCount",
                  style: const TextStyle(color: Colors.white),
                ),
                badgeStyle: BadgeStyle(
                  badgeColor: Theme
                      .of(context)
                      .primaryColor,
                ),
                child: GestureDetector(
                  onTap: () {
                    cartController.loadCart();
                  },
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    double minPrice = 0.0; // Giá trị khởi tạo cứng
    double maxPrice = 500000.0; // Giá trị khởi tạo cứng

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Lọc theo giá"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Giá thấp nhất: ${formatCurrency(minPrice)}",
                    style: TextStyle(color: Colors.orange), // Đặt màu chữ thành cam
                  ),
                  Slider(
                    value: minPrice,
                    min: 0,
                    max: 10000000,
                    divisions: 80,
                    label: minPrice.round().toString(),
                    activeColor: Colors.orange, // Đặt màu cho thanh trượt khi hoạt động
                    onChanged: (value) {
                      setState(() {
                        minPrice = value;
                        if (minPrice > maxPrice) {
                          maxPrice = minPrice; // Đảm bảo giá trị min không vượt quá max
                        }
                      });
                    },
                  ),
                  Text(
                    "Giá cao nhất: ${formatCurrency(maxPrice)}",
                    style: TextStyle(color: Colors.orange), // Đặt màu chữ thành cam
                  ),
                  Slider(
                    value: maxPrice,
                    min: minPrice, // Đảm bảo giá trị min không lớn hơn max
                    max: 10000000,
                    divisions: 80,
                    label: maxPrice.round().toString(),
                    activeColor: Colors.orange, // Đặt màu cho thanh trượt khi hoạt động
                    onChanged: (value) {
                      setState(() {
                        maxPrice = value;
                      });
                    },
                  ),

                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    homeController.getproductRecomend();
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: const Text(
                    "Tắt lọc",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: const Text("Hủy",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20
                    ),),
                ),
                TextButton(
                  onPressed: () {
                    homeController.getProductFilter(minPrice, maxPrice);
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: const Text("Lọc",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20
                    ),),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
