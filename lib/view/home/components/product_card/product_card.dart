import 'package:banhang/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:banhang/model/products_model.dart';

import '../../../../utils/app_constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.name,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${product.sellPrice}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade500, // Thay primary bằng backgroundColor
              foregroundColor: Colors.white, // Thay thế onPrimary bằng foregroundColor
            ),
            onPressed: () async {
              CartController().addCart(product.id, 2);
              _showDialog(context, 'Success', 'Thêm vào giỏ hàng thành công.');
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add to Cart"),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  // Hàm hiển thị dialog
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: Colors.green),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, color: Colors.green), // Use check icon for success
              const SizedBox(width: 8), // Spacing between icon and text
              Text(message), // Display the message
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
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