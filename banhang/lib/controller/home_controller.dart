import 'package:banhang/service/remote_service/remote_product_service.dart';
import 'package:get/get.dart';
import 'package:banhang/model/products_model.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<Product> products = List<Product>.empty(growable: true).obs;
  RxList<Product> productPobulars = List<Product>.empty(growable: true).obs;

  RxBool isLoading = false.obs; // Trạng thái tải dữ liệu
  RxBool isLoadingPopular = false.obs; // Trạng thái tải dữ liệu

  RxInt itemCart = 0.obs;

  @override
  void onInit() {
    getproduct();
    getproductRecomend();
    getitemcart();
    super.onInit();
  }

  void getitemcart() {
    itemCart.value++;
    //return itemCart.value;
  }


  void getproduct() async {
    try {
      isLoading(true);
      var result = await RemoteProductService().get();
      if (result != null) {
        products.assignAll(result); // Cập nhật danh sách products
      }
    } finally {
      print(products.length);
      isLoading(false);
    }
  }

  void getproductRecomend() async {
    try {
      isLoadingPopular(true);
      var result = await RemoteProductService().get();
      print('Recommended products result: $result'); // Kiểm tra kết quả
      if (result != null && result.isNotEmpty) {
        productPobulars.assignAll(result); // Cập nhật danh sách products
      } else {
        print('No popular products found'); // Thông báo không có sản phẩm
      }
    } finally {
      print(productPobulars.length);
      isLoadingPopular(false);
    }
  }

}
