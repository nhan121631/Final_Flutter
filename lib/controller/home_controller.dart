import 'package:banhang/controller/CartController.dart';
import 'package:banhang/service/remote_service/remote_product_service.dart';
import 'package:get/get.dart';
import 'package:banhang/model/products_model.dart';

import 'controllers.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();

  // Danh sách sản phẩm và sản phẩm phổ biến
  RxList<Product> products = List<Product>.empty(growable: true).obs;
  RxList<Product> productPobulars = List<Product>.empty(growable: true).obs;

  // Trạng thái tải dữ liệu
  RxBool isLoading = false.obs;
  RxBool isLoadingPopular = false.obs;
  RxBool isSearch = false.obs;
  RxBool isPopular = false.obs;

  // Số lượng mặt hàng trong giỏ
  RxInt itemCart = 0.obs;

  @override
  void onInit() {
    super.onInit();
  //  cartController.getQuantity(authController.user.value.id);

    getproduct(); // Lấy danh sách sản phẩm
    getproductRecomend(); // Lấy sản phẩm gợi ý
    getitemcart(); // Lấy số lượng mặt hàng trong giỏ
  }

  // Tăng số lượng mặt hàng trong giỏ
  void getitemcart() {
    itemCart.value++;
  }

  /// Lấy danh sách sản phẩm
  void getproduct() async {
    try {
      isLoading(true); // Bắt đầu trạng thái tải

      var result = await RemoteProductService().get(); // Gọi dịch vụ để lấy sản phẩm
      if (result != null) {
        products.assignAll(result); // Cập nhật danh sách sản phẩm
      }
    } catch (e) {
      print('Lỗi khi lấy sản phẩm: $e'); // Bắt lỗi nếu có
    } finally {
      print('Số lượng sản phẩm: ${products.length}'); // In ra số lượng sản phẩm
      isLoading(false); // Kết thúc trạng thái tải
    }
  }

  /// Lấy danh sách sản phẩm gợi ý
  Future<void> getproductRecomend() async {
    try {
      isLoadingPopular(true); // Bắt đầu trạng thái tải

      var result = await RemoteProductService().get(); // Gọi dịch vụ để lấy sản phẩm gợi ý
      print('Kết quả sản phẩm gợi ý: $result'); // Kiểm tra kết quả
      if (result != null && result.isNotEmpty) {
        productPobulars.assignAll(result); // Cập nhật danh sách sản phẩm gợi ý

      } else {
        print('Không tìm thấy sản phẩm phổ biến');
      }
    } catch (e) {
      print('Lỗi khi lấy sản phẩm gợi ý: $e'); // Bắt lỗi nếu có
    } finally {
      print('Số lượng sản phẩm gợi ý: ${productPobulars.length}'); // In ra số lượng sản phẩm gợi ý
      isLoadingPopular(false); // Kết thúc trạng thái tải
    }
  }

  /// Tìm kiếm sản phẩm
  void getProductSearch(String param) async {
    if (param.isNotEmpty) {
      isPopular(false);
      try {
        isLoadingPopular(true); // Bắt đầu trạng thái tải cho tìm kiếm
        var result = await RemoteProductService().search(param); // Gọi dịch vụ tìm kiếm
        if (result != null && result.isNotEmpty) {
          productPobulars.assignAll(result);
          isSearch(false);
        }
         else {
          productPobulars.assignAll(result);// Thông báo không có sản phẩm
          isSearch(true);

        }
      } catch (e) {
        print('Lỗi khi tìm kiếm sản phẩm: $e'); // Bắt lỗi nếu có
      } finally {
        print('Số lượng sản phẩm tìm thấy: ${productPobulars.length}'); // In ra số lượng sản phẩm tìm thấy
        isLoadingPopular(false); // Kết thúc trạng thái tải
      }
    } else {
      print("POPULARS");
      // Khi param là rỗng, gọi lại danh sách sản phẩm phổ biến
      isSearch(false);
      isPopular(true);
      await getproductRecomend();
    }

    print('Search: ${isSearch}');
  }
}
