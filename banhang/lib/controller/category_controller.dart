import 'package:get/get.dart';
import '../model/category_model.dart';
import '../service/remote_service/remote_category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();

  var categories = <Category>[].obs; // Observable list

  final RemoteCategoryService _remoteCategoryService = RemoteCategoryService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller is initialized
  }

  Future<void> fetchCategories() async {
    var fetchedCategories = await _remoteCategoryService.getCategories();
    if (fetchedCategories.isNotEmpty) {
      categories.assignAll(fetchedCategories); // Update observable list
    }
  }

  @override
  void onClose() {
    _remoteCategoryService.dispose(); // Clean up the client
    super.onClose();
  }
}
