  import 'package:banhang/controller/controllers.dart';
import 'package:banhang/model/cart_item_model.dart';
  import 'package:banhang/utils/app_constants.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';

  class CartItemWidget extends StatefulWidget {
    final CartItem cartitem;
    final ValueChanged<Map<double, int>> onQuantityChanged; // Callback function
    final ValueChanged<int> onRemove; // Callback function để xóa phần tử

    const CartItemWidget({
      super.key,
      required this.cartitem,
      required this.onQuantityChanged,
      required this.onRemove, // Truyền callback xóa

    });

    @override
    _CartItemWidgetState createState() => _CartItemWidgetState();
  }

  class _CartItemWidgetState extends State<CartItemWidget> {
    late int _qty;
    late double _sell;
    bool _isUpdating = false; // Biến để kiểm soát trạng thái cập nhật

    String formatCurrency(double amount) {
      final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
      return vnCurrency.format(amount);
    }
    @override
    void didUpdateWidget(CartItemWidget oldWidget) {
      super.didUpdateWidget(oldWidget);
      if (oldWidget.cartitem != widget.cartitem) {
        setState(() {
          _qty = widget.cartitem.quantity; // Cập nhật số lượng
          _sell = _qty * widget.cartitem.product.sellPrice; // Cập nhật lại tổng giá
        });
      }
    }

    @override
    void initState() {
      super.initState();
      _qty = widget.cartitem.quantity; // Khởi tạo số lượng từ cartitem
      _sell = widget.cartitem.product.sellPrice * _qty; // Tính tổng giá ban đầu
    }
    void _updateQuantity(int newQty, int i) {
      setState(() {
        _qty = newQty; // Cập nhật số lượng
        _sell = _qty * widget.cartitem.product.sellPrice; // Cập nhật tổng giá
      });
      widget.onQuantityChanged({
        widget.cartitem.product.sellPrice:i
      });  }
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
                image: DecorationImage(
                  image: NetworkImage('$baseUrl/image/${widget.cartitem.product.thumbnail}'),
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
                  Text(
                    '${widget.cartitem.product.name}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
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
                          onTap: ()  async{
                            await cartController.updateQuantityItem(widget.cartitem.id, 1);
                            setState(()  {
                              _updateQuantity(_qty + 1, 1);
                            });
                          },
                          child: const ComponentButtonPlusMinus(icon: Icons.add),
                        ),
                        Text(
                          "$_qty", // Hiển thị số lượng
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: _isUpdating
                              ? null // Vô hiệu hóa nút khi đang cập nhật
                              : () async {
                            setState(() {
                              _isUpdating = true; // Đánh dấu là đang cập nhật
                            });
                            if (_qty > 1) {
                              await cartController.updateQuantityItem(widget.cartitem.id, -1);
                              _updateQuantity(_qty - 1, -1);

                            }
                            setState(() {
                              _isUpdating = false; // Khôi phục trạng thái sau khi cập nhật
                            });
                          },
                          child: const ComponentButtonPlusMinus(icon: Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    print("remove");
                 widget.onRemove(widget.cartitem.id);
                 await cartController.deleteCartItem(widget.cartitem.id);
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.red, // Màu sắc cho biểu tượng hủy
                    size: 24, // Kích thước của biểu tượng
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  "₫${formatCurrency(_sell)}", // Hiển thị tổng giá
                  style: const TextStyle(
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