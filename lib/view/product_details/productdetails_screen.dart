import 'package:banhang/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/controllers.dart';
import '../../utils/app_constants.dart';
import 'package:flutter_html/flutter_html.dart';

class Comment {
  final String userName;
  final DateTime date;
  final double rating;
  final String content;

  Comment({
    required this.userName,
    required this.date,
    required this.rating,
    required this.content,
  });
}

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }

  NumberFormat formatter = NumberFormat('00');
  int _qty = 1;
  bool isaddCarted = false;

  Future<void> _addToCart() async {
    if (!isaddCarted) {
      isaddCarted = true;
      Get.snackbar("Success", '${widget.product.name} đã được thêm vào giỏ hàng');
      for (int i = 0; i < _qty; i++) {
        await cartController.addCart(widget.product.id, authController.user.value.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Center(
                    child: SizedBox(
                      width: 360,
                      height: 250,
                      child: Image.network(
                        '$baseUrl/image/${widget.product.thumbnail}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '\₫${formatCurrency(widget.product.sellPrice)}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Số lượng: ${widget.product.quantity}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    _buildQuantitySelector(),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'About this product:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Html(
                  data: widget.product.description,
                  style: {
                    "body": Style(
                      fontSize: const FontSize(20),
                      color: Colors.grey.shade700,
                    ),
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Kiểm tra nếu có bình luận, hiển thị ListView
              if (widget.product.reviews.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Reviews:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (widget.product.reviews.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true, // Để ListView hoạt động trong SingleChildScrollView
                    physics: NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn độc lập
                    itemCount: widget.product.reviews.length,
                    itemBuilder: (context, index) {
                      final comment = widget.product.reviews[index];

                      // Biến để lưu trữ ngày đã được định dạng
                      String formattedDate;
                      // Kiểm tra xem modifyedDate có khác null không
                      if (widget.product.reviews[index].modifiedDate != null) {
                        formattedDate = DateFormat('dd/MM/yyyy').format(widget.product.reviews[index].modifiedDate!);
                      } else {
                        // Nếu modifyedDate là null, sử dụng createdDate
                        formattedDate = DateFormat('dd/MM/yyyy').format(widget.product.reviews[index].createdDate!);
                      }

                      // Sử dụng formattedDate để hiển thị ngày và ghi chú
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    comment.user.fullname,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Ngày: $formattedDate${widget.product.reviews[index].modifiedDate != null ? ' (đã chỉnh sửa)' : ''}',
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    starIndex < comment.star ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                  );
                                }),
                              ),
                              SizedBox(height: 5),
                              Text(widget.product.reviews[index].comment), // Sửa đổi để sử dụng content
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: _addToCart,
          child: const Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (_qty > 1) {
                setState(() {
                  _qty--;
                  isaddCarted = false;
                });
              }
            },
            child: Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 32,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            formatter.format(_qty),
            style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _qty++;
                isaddCarted = false;
              });
            },
            child: Icon(
              Icons.keyboard_arrow_right_sharp,
              size: 32,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
    );
  }
}
