import 'package:banhang/utils/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/user_model.dart';

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
// Thêm hàm register
  Future<Map<String, dynamic>> register(
      String fullName, String username, String email, String password) async {
    // In thông tin gửi lên console để kiểm tra
    print("Sending request to $baseUrl/api/register with body: ${{
      'userName': username,
      'password': password,
      'fullName': fullName,
      'email': email,
    }}");

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'userName': username,
          'password': password,
          'fullName': fullName,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // Nếu đăng ký thành công
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        // Trường hợp thất bại, trả về thông tin lỗi
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

  // forgot pass
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      var response = await client.post(
        Uri.parse('$remoteUrl/forgot-password'),
        body: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success']) {
          print('Mã đặt lại mật khẩu đã gửi đến email: $email');
          return {
            'success': true,
            'message': data['message'],
          };
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to request password reset');
      }
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  // ResetpassWord
  Future<Map<String, dynamic>> resetPassword(String email, String resetCode, String newPassword) async {
    try {
      var response = await client.post(
        Uri.parse('$remoteUrl/reset-password'),
        body: {
          'email': email,
          'resetCode': resetCode,
          'newPassword': newPassword,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success']) {
          print('Đổi pass thành công cho email: $email');
          return {
            'success': true,
            'message': data['message'],
          };
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to request password reset');
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateUser({required int id, required String fullName, required String email}) async {
    try {
      final response = await http.put(
        Uri.parse('$remoteUrl/user?id=$id&fullName=$fullName&email=$email'),

      );

      if (response.statusCode == 200) {
        // Nếu cập nhật thành công
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return {
          'success': false,
          'message': 'Failed to update user',
          'error': response.body,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred',
        'error': e.toString(),
      };
    }
  }
}
