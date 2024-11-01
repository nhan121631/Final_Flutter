import 'package:banhang/controller/CartController.dart';
import 'package:banhang/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/controllers.dart';
import '../../utils/app_constants.dart';
import 'package:flutter_html/flutter_html.dart';

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
      for (int i = 0; i < _qty; i++) {
        await cartController.addCart(widget.product.id, authController.user.value.id);
      }

      Get.snackbar("Success", '${widget.product.name} đã được thêm vào giỏ hàng');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name), // Tiêu đề của trang
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Biểu tượng quay lại
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Thêm SingleChildScrollView ở đây
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Bo tròn bốn góc
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // Bo tròn bốn góc của hình ảnh
                  child: Center(
                    child: SizedBox(
                      width: 360, // Chiều rộng cố định
                      height: 250, // Chiều cao cố định
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
              // Phần mô tả với Scroll
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
                child: SingleChildScrollView( // Thêm thanh cuộn cho mô tả
                  child: Html(
                    data: widget.product.description, // Dữ liệu mô tả HTML
                    style: {
                      // Bạn có thể tùy chỉnh kiểu dáng cho HTML nếu cần
                      "body": Style(
                        fontSize: const FontSize(20),
                        color: Colors.grey.shade700,
                      ),
                    },
                  ),
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
