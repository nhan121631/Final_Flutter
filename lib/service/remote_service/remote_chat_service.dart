import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = "Your_API_key";

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "contents": [
          {
            "parts": [
              {"text": message}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['candidates'] != null && data['candidates'].isNotEmpty) {
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "Không có phản hồi từ AI.";
      }
    } else {
      throw Exception(
          "Không thể nhận được phản hồi. Mã lỗi: ${response.statusCode}");
    }
  }
}
