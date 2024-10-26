import 'package:flutter/material.dart';

class OrderForm extends StatefulWidget {
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
  double _totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Họ Tên Người Nhận'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Số Điện Thoại'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Địa Chỉ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Phương Thức Thanh Toán: '),
                  DropdownButton<String>(
                    value: _paymentMethod,
                    items: <String>['Cash', 'Credit Pay']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _paymentMethod = newValue!;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ghi Chú'),
                onSaved: (value) {
                  _note = value ?? '';
                },
              ),
              SizedBox(height: 20),
              Text(
                'Tổng Tiền: ₫${_totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Xử lý thanh toán ở đây
                    print('Họ Tên: $_fullName');
                    print('Số Điện Thoại: $_phone');
                    print('Địa Chỉ: $_address');
                    print('Phương Thức: $_paymentMethod');
                    print('Ghi Chú: $_note');
                  }
                },
                child: const Text('Xác Nhận Đặt Hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
