import 'package:banhang/controller/controllers.dart';
import 'package:banhang/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:banhang/model/products_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_constants.dart';
import '../../../product_details/productdetails_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    String formatCurrency(double amount) {
      final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
      return vnCurrency.format(amount);
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.details, arguments: {'product': product});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey.withOpacity(.3), width: .2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                '$baseUrl/image/${product.thumbnail}',
                fit: BoxFit.cover,
                height: 120,
                width: 120,
              ),
            ),
            const SizedBox(width: 10),
            // Wrap Column in Flexible to prevent overflow
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    maxLines: 2, // Allow wrapping to 2 lines
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\₫${formatCurrency(product.sellPrice)}',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange.shade500,
              ),
              onPressed: () async {
                cartController.addCart(product.id, authController.user.value.id);
                cartController.update();
                _showDialog(context, 'Success', 'Thêm vào giỏ hàng thành công.');
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text("Add to Cart"),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  // Show dialog function
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.green)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, color: Colors.green),
              const SizedBox(width: 8),
              Text(message),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<Product> products;

  ProductListView({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
