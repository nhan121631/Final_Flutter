import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://192.168.2.206:8081/flutter.com';

  /// Hàm đăng ký người dùng mới
  static Future<Map<String, dynamic>> register(
      String fullName, String username, String email, String password) async {
    // In thông tin gửi lên console để kiểm tra
    print(
        "Sending request to $baseUrl/api/register with body: ${jsonEncode(<String, String>{
          'fullName': fullName,
          'userName': username,
          'email': email,
          'password': password,
        })}");

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'fullName': fullName,
          'userName': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Giả sử API trả về JSON với thông tin thành công
        return jsonDecode(response.body);
      } else {
        // Trả về thông tin lỗi nếu đăng ký thất bại
        return {
          'success': false,
          'message': 'Failed to create account',
          'error': response.body,
        };
      }
    } catch (e) {
      // Xử lý ngoại lệ nếu có lỗi kết nối hoặc lỗi không mong muốn
      return {
        'success': false,
        'message': 'An error occurred',
        'error': e.toString(),
      };
    }
  }
}
