import 'dart:convert'; // Đảm bảo nhập thư viện này
import 'package:banhang/model/cart_item_model.dart';
import 'package:banhang/utils/app_constants.dart';
import 'package:http/http.dart' as http; // Sử dụng alias 'http'

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

  Future<List<CartItem>> getCartItem(int idUser) async {
    print(remoteUrl);
    try {
      // Tạo URL với tham số idUser
      var response = await client.get(
        Uri.parse('${remoteUrl}/get?user_id=$idUser'),
      );

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        return jsonResponse.map((cartitem) => CartItem.fromJson(cartitem)).toList();
      } else {
        // Nếu không thành công, ném ra một ngoại lệ
        throw Exception('Failed to get cartItem');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
      return [];
    }
  }
  Future<void> deleteCartItem(int id) async {
    try {
      var response = await client.delete(
        Uri.parse('$remoteUrl/delete/item?id=$id'),
      );

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        print('Đã xóa Item ra khỏi giỏ hàng');
      } else {
        throw Exception('Failed to delete cart item');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
    }
  }

  Future<void> updateCartItem(int id, int state) async {
    try {
      var response = await client.put(
        Uri.parse('$remoteUrl/quantity?id=$id&state=$state'),
      );

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        print('Đã update quantity');
      } else {
        throw Exception('Failed to update quantity cart item');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
    }
  }
}
