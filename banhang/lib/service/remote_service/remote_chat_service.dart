import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = "AIzaSyBNa2gR4gLPmrBIFeUvGqs6e8KfUYw7LZ0"; // Thay bằng API key của bạn
  final List<Map<String, dynamic>> history = []; // Lưu trữ lịch sử cuộc trò chuyện

  Future<String> sendMessage(String message) async {
    // Thêm tin nhắn của người dùng vào lịch sử
    history.add({
      "role": "user",
      "parts": [
        {"text": message}
      ]
    });

    // Tạo danh sách "contents" từ lịch sử để gửi cho API
    final List<Map<String, dynamic>> contents = history.toList();

    // Gửi yêu cầu tới API với toàn bộ lịch sử cuộc trò chuyện
    final response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "contents": contents,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['candidates'] != null && data['candidates'].isNotEmpty) {
        final aiResponse = data['candidates'][0]['content']['parts'][0]['text'];
        // Thêm phản hồi của AI vào lịch sử
        history.add({
          "role": "model",
          "parts": [
            {"text": aiResponse}
          ]
        });
        return aiResponse;
      } else {
        return "Không có phản hồi từ AI.";
      }
    } else {
      throw Exception("Không thể nhận được phản hồi. Mã lỗi: ${response.statusCode}");
    }
  }
}
