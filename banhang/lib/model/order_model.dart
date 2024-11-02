import 'dart:convert';

import 'package:banhang/model/user_model.dart';

import 'order_item_model.dart';

class Order {
  final int id;
 // final User user;
 final List<OrderItem> orderItems;
  final String fullname;
  final String phone;
  final String address;
  final String note;
  final int status;
  final int payment;
  final double totalPrice;
  final DateTime? createdDate;
  final DateTime? modifiedDate;

  Order({
    required this.id,
//    required this.user,
   required this.orderItems,
    required this.fullname,
    required this.phone,
    required this.address,
    required this.note,
    required this.status,
    required this.payment,
    required this.totalPrice,
    required this.createdDate,
    required this.modifiedDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
  //    user: User.fromJson(json['user']),
      orderItems: (json['orderitems'] as List)
          .map((item) => OrderItem.fromJson(item))
           .toList(),
      fullname: json['fullname'],
      phone: json['phone'],
      address: json['address'],
      note: json['note'],
      status: json['status'],
      payment: json['payment'],
      totalPrice: json['totalPrice'].toDouble(),
      createdDate: json['createdDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdDate'])
          : null,
    modifiedDate: json['modifiedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['modifiedDate'])
          : null, // Trả về null nếu modifiedDate là null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
  //    'user': user.toJson(),
      'orderitems': orderItems.map((item) => item.toJson()).toList(),
      'fullname': fullname,
      'phone': phone,
      'address': address,
      'note': note,
      'status': status,
      'payment': payment,
      'totalPrice': totalPrice,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'modifiedDate': modifiedDate?.millisecondsSinceEpoch,
    };
  }
}