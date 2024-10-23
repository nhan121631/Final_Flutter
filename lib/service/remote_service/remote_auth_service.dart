import 'package:banhang/utils/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api';

/*
   AuthService(this.client, String baseUrl) : remoteUrl = '$baseUrl/api';
*/

  Future<Map<String, dynamic>> login(String username, String password) async {
    print(remoteUrl);
    try {
      var response = await client.post(
        Uri.parse('${remoteUrl}/login'),
        body: {
          'username': username,
          'password': password,
        },
      );
      print('${remoteUrl}/login');

      if (response.statusCode == 200) {
        // Chuyển đổi phản hồi thành JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Kiểm tra nếu đăng nhập thành công
        if (data['success']) {
          print('Login successful: ${data['user']}');
          return data['user']; // Trả về thông tin người dùng
        } else {
          throw Exception(data['message']); // Ném ra thông báo lỗi
        }
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Ném lại ngoại lệ để xử lý ở nơi khác
    }
  }
}


