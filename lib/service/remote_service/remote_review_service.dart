import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/app_constants.dart';

class ReviewService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/review';

  Future<String> addReview({
    required int userId,
    required int productId,
    required int star,
    required String comment,
  }) async {
    final url = Uri.parse('$remoteUrl/add');
    print(url);

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded', // Đảm bảo kiểu nội dung chính xác
        },
        body: {
          'user_id': userId.toString(),
          'product_id': productId.toString(),
          'star': star.toString(),
          'comment': comment,
        },
      );

      // In ra phản hồi từ server để kiểm tra
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        // Thử decode
        return response.body; // Không cần gọi json.decode

      } else {
        return 'Thêm review thất bại: ${response.statusCode}';
      }
    } catch (e) {
      print('Lỗi khi kết nối đến server: $e');
      return 'Lỗi khi kết nối đến server: $e';
    } finally {
      client.close(); // Đóng client sau khi sử dụng để giải phóng tài nguyên
    }
  }
}
