import 'package:banhang/controller/CartController.dart';
import 'package:banhang/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';

import '../route/app_route.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You should ensure that CartController is initialized globally in your app
    // Either in your main function or another appropriate place
    // Get.put(CartController()); // Place this in the main() function of your app

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

          Obx(() {
              return Badge(
                badgeContent: Text(
                  "${cartController.itemCart.value}",
                  style: const TextStyle(color: Colors.white),
                ),
                badgeStyle: BadgeStyle(
                  badgeColor: Theme.of(context).primaryColor,
                ),
                child:  GestureDetector(
            onTap: () {
              cartController.loadCart();
            //   cartController.getCartItem(authController.user.value.id);
            // Get.toNamed(AppRoute.cart);
            // Navigator.pushNamed(context, '/cart');
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
            }),


          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
