import 'package:banhang/view/home/components/carousel_slider/product_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderView extends StatefulWidget {
  const CarouselSliderView({Key? key}) : super(key: key);

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

class _CarouselSliderViewState extends State<CarouselSliderView> {
  // Tạo danh sách các đường dẫn hình ảnh trong assets
  final List<String> _imagePaths = [
    'assets/images/cr_1.png',
    'assets/images/cr_2.webp',
    'assets/images/cr_3.jpg',
  ];

  late List<Widget> _productCards;

  @override
  void initState() {
    super.initState();
    // Khởi tạo _productCards trong initState
    _productCards = _imagePaths.map((path) => ProductCard(imageUrl: path)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: _productCards,
      options: CarouselOptions(
        autoPlay: true,
      ),
    );
  }
}
