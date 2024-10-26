import 'package:banhang/controller/controllers.dart';
import 'package:banhang/route/app_page.dart';
import 'package:banhang/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:banhang/controller/order_controller.dart'; // Import OrderController

class OrderForm extends StatefulWidget {
  final double total;
  OrderForm({super.key, required this.total});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _phone = '';
  String _address = '';
  String _paymentMethod = 'Cash';
  String _note = '';

  // Hàm định dạng tiền tệ
  String formatCurrency(double amount) {
    final NumberFormat vnCurrency = NumberFormat('#,##0', 'vi_VN');
    return vnCurrency.format(amount);
  }

  // Hàm hiển thị AlertDialog xác nhận thanh toán
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác Nhận Đặt Hàng',
          style: TextStyle(color: Colors.orange,
          fontSize: 25),),
          content: const Text('Bạn có chắc chắn muốn đặt hàng không?',
          style: TextStyle(color: Colors.grey,
          fontSize: 20),),
          actions: <Widget>[
            TextButton(
              child: const Text('No',
              style: TextStyle(color: Colors.red,
              fontSize: 25),),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: const Text('Yes',
              style: TextStyle(color: Colors.green,
              fontSize: 25,)),
              onPressed: () async {
                Navigator.of(context).pop(); // Đóng hộp thoại trước khi thực hiện thanh toán
                await _processOrder(); // Gọi hàm thực hiện thanh toán
              },
            ),
          ],
        );
      },
    );
  }

  // Hàm xử lý thanh toán
  Future<void> _processOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Gọi đến OrderController để thực hiện checkout
      await orderController.checkOutOrder(
        userId: authController.user.value.id,
        name: _fullName,
        phone: _phone,
        address: _address,
        payment: _paymentMethod == 'Cash' ? 1 : 2,
        note: _note,
        total: widget.total,
      );

      // Hiển thị thông báo thành công hoặc lỗi
      String message = orderController.orderMessage.value;
      Get.snackbar("OK", message);
      Get.offAllNamed(AppRoute.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt Hàng'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thông Tin Người Nhận',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Họ Tên Người Nhận',
                hint: 'Nhập họ tên',
                icon: Icons.person,
                onSaved: (value) => _fullName = value!,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Số Điện Thoại',
                hint: 'Nhập số điện thoại',
                icon: Icons.phone,
                onSaved: (value) => _phone = value!,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Địa Chỉ',
                hint: 'Nhập địa chỉ',
                icon: Icons.location_on,
                onSaved: (value) => _address = value!,
              ),
              const SizedBox(height: 16),
              const Text(
                'Phương Thức Thanh Toán',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.payment, color: Colors.orange),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _paymentMethod,
                    items: ['Cash', 'Credit Pay']
                        .map((method) => DropdownMenuItem<String>(
                      value: method,
                      child: Text(method),
                    ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _paymentMethod = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Ghi Chú',
                hint: 'Ghi chú nếu có',
                icon: Icons.note,
                onSaved: (value) => _note = value ?? '',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              const Divider(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Tổng Tiền: ₫${formatCurrency(widget.total)}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _showConfirmationDialog, // Gọi hộp thoại xác nhận
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text('Xác Nhận Đặt Hàng'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required FormFieldSetter<String> onSaved,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.orange),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
