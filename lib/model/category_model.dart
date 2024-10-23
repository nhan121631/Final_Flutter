import 'package:banhang/model/products_model.dart';

class Category {
  final int id;
  final String name;
  final List<Product> products;

  // Constructor
  Category({
    required this.id,
    required this.name,
    required this.products,
  });

  // Phương thức fromJson để tạo Category từ JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      products: (json['news'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'news': products.map((product) => product.toJson()).toList(),
    };
  }

  int get productCount => products.length;

  @override
  String toString() {
    return 'Category{id: $id, name: $name, productCount: $productCount}';
  }
}
