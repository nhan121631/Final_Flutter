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
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      isLoadingMore = true;
    });
    await orderController.fetchOrders(authController.user.value.id);
    setState(() {
      orders = orderController.orders;
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Danh sách Đơn Hàng'),
        ),
        backgroundColor: Colors.orange.shade800,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: orders.length + 1,
        itemBuilder: (context, index) {
          if (index < orders.length) {
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
                            'Đơn hàng #${index + 1}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Chip(
                            label: Text(
                              order.status == 0
                                  ? "Đang xử lý"
                                  : order.status == 1
                                  ? "Đang giao"
                                  : order.status == 2
                                  ? "Đã giao"
                                  : "Trạng thái không xác định",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: order.status == 0
                                ? Colors.orange
                                : order.status == 1
                                ? Colors.yellow.shade700
                                : order.status == 2
                                ? Colors.green
                                : Colors.grey,
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
          } else {
            // Hiển thị nút "Tải thêm" khi cuộn đến cuối
            return Center(
              child: isLoadingMore
                  ? CircularProgressIndicator() // Hiển thị vòng tròn tải khi đang tải thêm
                  : ElevatedButton(
                onPressed: _fetchOrders,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Màu nền cam cho nút
                ),
                child: const Text('Tải thêm'),
              ),
            );

          }
        },
      ),
    );
  }
}
