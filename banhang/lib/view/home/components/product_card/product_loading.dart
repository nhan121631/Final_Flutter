import 'package:banhang/view/home/components/product_card/product_card_loading.dart';
import 'package:flutter/material.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading ({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Container(
      height: 140,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index)=> const ProductCardLoading()
      ),
    );
  }
}