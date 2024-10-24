import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/app_constants.dart';

class AuthService {
  var client = http.Client();
  // final String baseUrl = 'https://yourapiurl.com'; // URL cơ bản của API

  Future<Map<String, dynamic>> login(String username, String password) async {
    var url = Uri.parse('$baseUrl/api/login'); // Tạo URI từ đường dẫn API
    var body = {
      'username': username,
      'password': password,
    };

    try {
      // Gửi yêu cầu POST đến API
      var response = await http.post(
        url,
        body: body,
      );

      if (response.statusCode == 200) {
        // Giải mã phản hồi từ API thành JSON
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

        return jsonResponse;
      } else {
        // Xử lý lỗi nếu status code không phải là 200
        return {'success': false, 'message': 'Lỗi mạng hoặc API không phản hồi'};
      }
    } catch (e) {
      // Xử lý lỗi trong quá trình gửi yêu cầu
      return {'success': false, 'message': 'Đã xảy ra lỗi: $e'};
    }
  }
}