import 'package:banhang/model/review_model.dart';

class Product {
  final int id; // ID của sản phẩm
  final String name; // Tên sản phẩm
  final double costPrice; // Giá gốc
  final double sellPrice; // Giá bán
  final String thumbnail; // Hình ảnh thu nhỏ
  final int quantity; // Số lượng
  final String description; // Mô tả
  final List<Review> reviews; // Danh sách đánh giá

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.costPrice,
    required this.sellPrice,
    required this.thumbnail,
    required this.quantity,
    required this.description,
    required this.reviews,
  });

  // Phương thức fromJson
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      costPrice: json['costPrice'].toDouble(),
      sellPrice: json['sellPrice'].toDouble(),
      thumbnail: json['thumbnail'],
      quantity: json['quantity'],
      description: json['description'],
      reviews: (json['reviews'] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(), // Chuyển đổi danh sách reviews từ JSON
    );
  }

  // Phương thức toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'costPrice': costPrice,
      'sellPrice': sellPrice,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'description': description,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
