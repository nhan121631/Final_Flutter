import 'dart:convert';

import 'package:banhang/model/products_model.dart';

class OrderItem {
  final int id;
  final Product product;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,

    };
  }
}