import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/order_model.dart';
import '../../utils/app_constants.dart';

class OrderService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/order';

  Future<List<Order>> getOrders(int userId) async {
    final url = Uri.parse('$remoteUrl/get?user_id=$userId');

    try {
      var response = await client.get(Uri.parse('$remoteUrl/get?user_id=$userId'));

      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // In ra phản hồi

        // Giải mã JSON và lấy danh sách Category
        var jsonResponse = json.decode(response.body) as List;
        print ("ok $jsonResponse");
        return jsonResponse
            .map((item) => Order.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load categories, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

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
