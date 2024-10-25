import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemWidget extends StatelessWidget {
  final String textLink;
  final int index;

  const CartItemWidget({
    super.key,
    required this.textLink,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/product_test.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Spacer(flex: 1),
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sample Product",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF606060),
                  ),
                ),
                const Spacer(flex: 1),
                SizedBox(
                  width: 130,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const ComponentButtonPlusMinus(icon: Icons.add),
                      ),
                      const Text(
                        "01",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: const ComponentButtonPlusMinus(icon: Icons.remove),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(flex: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // Xử lý hành động xóa ở đây
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red, // Màu sắc cho biểu tượng hủy
                  size: 24, // Kích thước của biểu tượng
                ),
              ),
              const Spacer(flex: 1),
              const Text(
                "\$100.00",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF303030),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TotalSumm extends StatelessWidget {
  const TotalSumm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Text(
              "Total",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF808080),
              ),
            ),
            Spacer(flex: 1),
            Text(
              "\$300.00",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentButtonPlusMinus extends StatelessWidget {
  final IconData icon;

  const ComponentButtonPlusMinus({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFE0E0E0),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
