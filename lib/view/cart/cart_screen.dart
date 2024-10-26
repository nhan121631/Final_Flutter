import 'package:banhang/controller/controllers.dart';
import 'package:banhang/route/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../model/cart_item_model.dart';
import 'components/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = []; // Danh sách giỏ hàng
  double _total = 0.0;

  // Format currency for display
  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }

  // Calculate total cart price
  void _calculateTotal() {
    double total = 0.0;
    for (var cartItem in cartItems) {
      total += cartItem.product.sellPrice * cartItem.quantity;
    }
    setState(() {
      _total = total;
    });
  }

  @override
  void initState() {
    super.initState();
    cartItems = cartController.cartitems;
    for(int i = 0; i<cartItems.length; i++){
      print("Ban đầu: id: ${cartItems[i].id} qty ${cartItems[i].quantity} name ${cartItems[i].product.name}");
    }
    _calculateTotal();
  }

  // Update total based on quantity change
  void _onQuantityChanged(Map<double, int> productSell) {
    setState(() {
      double sell = productSell.keys.first;
      int i = productSell.values.first;
      print("i: ${i}");
      if (i < 0) {
        _total -= sell;
      } else {
        _total += sell;
      }
    });
  }

  // // Remove item from cart
  // void _removeItemFromCart(int index) {
  //   setState(() {
  //     print("index ${index}");
  //     cartController.cartitems.removeAt(index);
  //   });
  //  // _calculateTotal();
  // }

  // Hàm xóa item
  void _onRemove(int itemId) {
    setState(() {
      print("id removw: ${itemId}");
      final itemToRemove = cartItems.firstWhere((item) => item.id == itemId);
      _total -= itemToRemove.quantity * itemToRemove.product.sellPrice;
      cartItems.removeWhere((item) => item.id == itemId);
      for(int i = 0; i<cartItems.length; i++){
        print("id: ${cartItems[i].id} qty ${cartItems[i].quantity} name ${cartItems[i].product.name}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
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
        body:
        // Obx((){
        // return
          SafeArea(
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
                          cartitem:cartItems[index],
                          onQuantityChanged: _onQuantityChanged,
                          onRemove: _onRemove,
                        );
                      },
                      itemCount: cartItems.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(),
                        );
                      },
                    ),
                  ),
                  // Promo code field and total price section
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
                            "₫${formatCurrency(_total)}",
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
                      onPressed: () {
                        if (!isChecked) {
                          isChecked = true;

                          // Giả sử bạn có danh sách cartItems
                          bool isQuantitySufficient = true; // Biến để kiểm tra tình trạng số lượng
                          List<String> insufficientItems = []; // Danh sách lưu trữ sản phẩm không đủ

                          for (var item in cartItems) {
                            // Kiểm tra số lượng từng item
                            if (item.quantity > item.product.quantity) {
                              isQuantitySufficient = false; // Đánh dấu là không đủ số lượng
                              // Thêm thông tin sản phẩm không đủ vào danh sách
                              insufficientItems.add('${item.product.name} (Số lượng có sẵn: ${item.product.quantity})');
                            }
                          }

                          // Nếu số lượng không đủ
                          if (!isQuantitySufficient) {
                            // Tạo thông báo với danh sách sản phẩm không đủ
                            String insufficientMessage = insufficientItems.join(', ');
                            Get.snackbar(
                              "Thông báo",
                              "Không đủ số lượng cho các sản phẩm: $insufficientMessage",
                            );
                          } else {
                            // Nếu có sản phẩm và tổng khác 0
                            if (_total != 0) {
                              Get.toNamed(
                                AppRoute.orderform,
                                arguments: {'totalAmount': _total},
                              );
                            } else {
                              Get.snackbar("Fail", "Không có giỏ hàng để thanh toán");
                            }
                          }
                        }
                      },


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
  //}),
      ),
    );
  }
}
