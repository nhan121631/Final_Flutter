import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/app_constants.dart';

class OrderService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/order';

  Future<String> checkOutOrder({
    required int userId,
    required String name,
    required String phone,
    required String address,
    required int payment,
    required String note,
    required double total,
  }) async {
    final url = Uri.parse('$remoteUrl/check');
    print(url);
    final response = await http.post(
      url,
      body: {
        'user_id': userId.toString(),
        'name': name,
        'phone': phone,
        'address': address,
        'payment': payment.toString(),
        'note': note,
        'total': total.toString(),
      },
    );

    if (response.statusCode == 200) {
      return 'Successfully checked out'; // Hoặc trả về dữ liệu nào đó nếu cần
    } else {
      throw Exception('Failed to check out: ${response.body}');
    }
  }
}
