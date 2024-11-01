import 'package:banhang/model/products_model.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  final Product product;

  const RatingScreen({required this.product});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int rating = 0; // Đánh giá bằng sao
  String? comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh Giá Sản Phẩm'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sản phẩm: ${widget.product.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Đánh giá sản phẩm:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < rating ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nhận xét',
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (rating > 0 && comment != null && comment!.isNotEmpty) {
                  // Xử lý gửi đánh giá cho sản phẩm
                  print('Đánh giá cho ${widget.product.name}: $rating sao');
                  print('Nhận xét: $comment');
                  // Gọi API để gửi thông tin đánh giá
                  Navigator.pop(context); // Trở về màn hình trước
                } else {
                  // Hiển thị thông báo nếu chưa nhập đầy đủ
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin đánh giá')),
                  );
                }
              },
              child: const Text('Gửi Đánh Giá'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
