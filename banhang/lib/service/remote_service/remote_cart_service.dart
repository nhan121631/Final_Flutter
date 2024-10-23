import 'dart:convert'; // Đảm bảo nhập thư viện này
import 'package:banhang/utils/app_constants.dart';
import 'package:http/http.dart' as http; // Sử dụng alias 'http'
import 'package:banhang/model/products_model.dart';

class RemoteCartService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/cart';

  Future<void> addCart(int idProduct, int idUser) async {
    print(remoteUrl);
    try {
      // Tạo URL với các tham số idProduct và idUser
      var response = await client.post(
        Uri.parse('${remoteUrl}/add'),
        body: {
          'product_id': idProduct.toString(),
          'user_id': idUser.toString(),
        },
      );

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        // Nếu thành công, có thể in ra thông báo hoặc xử lý thêm
        print('Product added to cart successfully.');
      } else {
        // Nếu không thành công, ném ra một ngoại lệ
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
    }
  }
  Future<int> getQuantity(int idUser) async {
    print(remoteUrl);
    try {
      // Tạo URL với tham số idUser
      var response = await client.get(
        Uri.parse('${remoteUrl}/quantity?user_id=$idUser'),
      );

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        return int.parse(response.body); // Chuyển đổi nội dung phản hồi thành int
      } else {
        // Nếu không thành công, ném ra một ngoại lệ
        throw Exception('Failed to get quantity');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
      return 0;
    }
  }

}
