import 'package:banhang/model/products_model.dart';

class CartItem {
  final int id;
  final int quantity;
  final Product product;

  CartItem({
    required this.id,
    required this.quantity,
    required this.product,
  });

  // Phương thức fromJson để tạo CartItem từ JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']), // Chỉ cần ánh xạ 1 sản phẩm
    );
  }
}
