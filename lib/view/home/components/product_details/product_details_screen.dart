import 'package:banhang/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components/product_carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  NumberFormat formatter = NumberFormat('00');
  int _qty = 1;
  int _tagIndex = 0;

  void _addToCart() {
    // Giả sử có một CartController hoặc tương tự để xử lý thêm sản phẩm vào giỏ hàng
    // CartController().addToCart(widget.product, _qty);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.name} đã được thêm vào giỏ hàng')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductCarouselSlider(images: widget.product.images),
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
                '\$${widget.product.tags.first.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  _buildQuantitySelector(),
                  const SizedBox(width: 10),
                  _buildTagSelector(),
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
              child: Text(
                widget.product.description,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            )
          ],
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

  Widget _buildTagSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (_tagIndex > 0) {
                setState(() {
                  _tagIndex--;
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
            widget.product.tags[_tagIndex].title,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
          ),
          InkWell(
            onTap: () {
              if (_tagIndex != (widget.product.tags.length - 1)) {
                setState(() {
                  _tagIndex++;
                });
              }
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
