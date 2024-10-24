import 'dart:convert';
import 'package:banhang/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:banhang/model/category_model.dart';
class RemoteCategoryService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/category/get';
  Future<List<Category>> getCategories() async {
    print(remoteUrl);
    try {
      var response = await client.get(Uri.parse(remoteUrl));

      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // In ra phản hồi

        // Giải mã JSON và lấy danh sách Category
        var jsonResponse = json.decode(response.body) as List;
        return jsonResponse
            .map((item) => Category.fromJson(item)) // Lấy trực tiếp từng item
            .toList();
      } else {
        throw Exception('Failed to load categories, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  void dispose() {
    client.close();
  }
}