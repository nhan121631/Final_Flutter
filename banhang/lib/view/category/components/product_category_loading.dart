import 'package:banhang/view/category/components/product_category_card_loading.dart';
import 'package:flutter/material.dart';

class ProductCateLoading extends StatelessWidget {
  const ProductCateLoading ({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Container(
      height: 140,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index)=> const ProductCardLoading()
      ),
    );
  }
}