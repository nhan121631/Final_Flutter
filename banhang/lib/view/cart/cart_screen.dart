import 'package:banhang/controller/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Hàm tính tổng giá trị của các sản phẩm trong giỏ hàng
  double calculateTotal() {
    return cartController.cartItems.fold(0, (sum, item) => sum + (item.product.sellPrice * item.quantity));
  }

  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: const Text(
            "My Cart",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Danh sách sản phẩm trong giỏ hàng
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.58,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return CartItemWidget(
                          cartItem: cartController.cartItems[index],
                        );
                      },
                      itemCount: cartController.cartItems.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tổng tiền giỏ hàng
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF808080), // màu xám
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\₫${formatCurrency(calculateTotal())}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 60),
                        backgroundColor: Colors.black,
                        elevation: 15,
                        shadowColor: Colors.black,
                      ),
                      child: const Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
