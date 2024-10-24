import 'dart:convert'; // Đảm bảo nhập thư viện này
import 'package:banhang/utils/app_constants.dart';
import 'package:http/http.dart' as http; // Sử dụng alias 'http'
import 'package:banhang/model/products_model.dart';

class RemoteProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/getproduct';

  Future<List<Product>> get() async {
    print(remoteUrl);
    try {
      var response = await client.get(Uri.parse(remoteUrl));

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        // Nếu thành công, chuyển đổi JSON thành danh sách Product
        var jsonResponse = json.decode(response.body) as List;
        return jsonResponse
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        // Nếu không thành công, ném ra một ngoại lệ
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
      return [];
    }
  }
}
