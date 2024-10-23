import 'package:banhang/view/home/components/carousel_slider/product_card.dart';
import 'package:flutter/material.dart';
import 'package:banhang/model/products_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderView extends StatefulWidget {
  final List<Product> products;
  const CarouselSliderView({Key? key, required this.products})
      : super(key: key);

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

class _CarouselSliderViewState extends State<CarouselSliderView> {
  int _currentIndex = 0;
  late List<Widget> _products;
  @override
  void initState() {
    _products =
        widget.products.map((e) => ProductCard(imageUrl: e.thumbnail)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _products,
          options: CarouselOptions(
            autoPlay: true,
          ),
        )
      ],
    );
  }
}
