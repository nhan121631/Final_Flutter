import 'package:banhang/model/order_item_model.dart';
import 'package:banhang/view/order/rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({required this.order});

  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết Đơn Hàng'),
        backgroundColor: Colors.orange.shade800,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Người Nhận: ${order.fullname}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Số điện thoại: ${order.phone}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Ngày đặt: ${order.createdDate}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sản phẩm trong đơn hàng:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderItems.length,
                itemBuilder: (context, index) {
                  final item = order.orderItems[index];
                  return ProductCard(item: item, orderStatus: order.status);
                },
              ),
            ),
            Divider(color: Colors.grey.shade400),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng tiền:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₫${formatCurrency(order.totalPrice)}',
                    style: const TextStyle(
                        fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final OrderItem item;
  final int orderStatus;

  const ProductCard({required this.item, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.product.name, // Tên sản phẩm
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Số lượng: ${item.quantity}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 10),
            if (orderStatus == 2) // Chỉ hiển thị nếu trạng thái đơn hàng là 2
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RatingScreen(product: item.product),
                    ),
                  );
                },
                child: const Text('Đánh Giá Sản Phẩm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
