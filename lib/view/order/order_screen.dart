import 'package:banhang/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/order_model.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}
String formatCurrency(double amount) {
  final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
  return vnCurrency.format(amount);
}
class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    orderController.fetchOrders(authController.user.value.id);
    orders = orderController.orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Đơn Hàng'),
        backgroundColor: Colors.orange.shade800,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => OrderDetailScreen(order: order));
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đơn hàng #${index+1}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          label: Text(
                            order.status == 2 ? "Hoàn thành" : "Đang xử lý",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: order.status == 3
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Ngày đặt: ${order.createdDate}',
                        style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng tiền:',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          '₫${formatCurrency(order.totalPrice)}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
