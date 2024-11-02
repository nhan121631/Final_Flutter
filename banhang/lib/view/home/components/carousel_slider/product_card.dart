import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl; // Đường dẫn đến ảnh trong asset

  const ProductCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          imageUrl, // Sử dụng Image.asset để tải ảnh từ asset
          fit: BoxFit.cover,
          width: double.infinity,
          // Không sử dụng loadingBuilder vì không cần thiết với assets
          errorBuilder: (context, error, stackTrace) {
            // Hiển thị khi có lỗi xảy ra trong quá trình tải ảnh
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
