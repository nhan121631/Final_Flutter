import 'package:banhang/controller/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _total = 0.0; // Biến để lưu tổng giá trị
  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }

  // Phương thức để tính tổng
  void _calculateTotal() {
    double total = 0.0;
    for (var cartItem in cartController.cartItems) {
      total += cartItem.product.sellPrice * cartItem.quantity; // Tính tổng
    }
    setState(() {
      _total = total; // Cập nhật tổng
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateTotal(); // Tính tổng khi khởi tạo
  }
  void _onQuantityChanged(Map<double, int> productSell) {
    setState(() {
      double  sell= productSell.keys.first;
      int i = productSell.values.first;
      if(i<0) {
        _total -= sell;
        print("i: ${i}, total: ${_total}");
      }else{
        _total += sell;
        print("i: ${i}, total: ${_total}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: const Text(
            "My Cart",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.58,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return CartItemWidget(
                          cartitem: cartController.cartItems[index],
                          onQuantityChanged: _onQuantityChanged,
                        );
                      },
                      itemCount: cartController.cartItems.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Promo Code",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.chevron_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF808080),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\₫ ${formatCurrency(_total)}", // Hiển thị tổng giá trị
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 60),
                        backgroundColor: Colors.orange,
                        elevation: 15,
                        shadowColor: Colors.orange,
                      ),
                      child: const Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}