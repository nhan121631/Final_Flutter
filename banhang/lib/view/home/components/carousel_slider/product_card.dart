import 'package:banhang/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;

  const ProductCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.network(
          '$baseUrl/image/${widget.imageUrl}',
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              // Khi tải ảnh hoàn tất
              return child;
            } else {
              // Hiển thị hiệu ứng shimmer khi đang tải ảnh
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(color: Colors.grey),
                  ),
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            // Hiển thị khi có lỗi xảy ra trong quá trình tải ảnh
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(
                Icons.error,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
