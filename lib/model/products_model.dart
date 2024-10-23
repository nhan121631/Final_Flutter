class Tag {
  final String title;
  final double price;

  Tag({required this.title, required this.price});
}


class Product {
  final int id; // ID của sản phẩm
  final String name; // Tên sản phẩm
  final double costPrice; // Giá gốc
  final double sellPrice; // Giá bán
  final String thumbnail; // Hình ảnh thu nhỏ
  final int quantity; // Số lượng
  final String description; // Mô tả
  final List<String> images; // Danh sách hình ảnh
  final List<Tag> tags; // Danh sách tag (giá)

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.costPrice,
    required this.sellPrice,
    required this.thumbnail,
    required this.quantity,
    required this.description,
    required this.images,
    required this.tags,
  });
// Phương thức fromJson
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      costPrice: json['costPrice'].toDouble(), // Chuyển đổi sang double
      sellPrice: json['sellPrice'].toDouble(), // Chuyển đổi sang double
      thumbnail: json['thumbnail'],
      quantity: json['quantity'],
      description: json['description'],
      images: json['images'],
      tags: json['tags'],
    );
  }

  // Phương thức toJson (tùy chọn, nếu bạn muốn chuyển đối tượng về JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cost_price': costPrice,
      'sell_price': sellPrice,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'description': description,
    };
  }
}
