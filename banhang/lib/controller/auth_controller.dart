import 'package:get/get.dart';
import 'dart:convert';
// import 'package:hive/hive.dart';
import '../model/user_model.dart';
import '../service/remote_service/remote_auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Lấy instance của AuthController

  var isLoggedIn = false.obs;
  var user = User(id: 0, username: '', email: '', password: '', fullname: '').obs; // Thông tin người dùng
  var error = ''.obs;
  final AuthService authService = AuthService();

  void setLoginStatus(bool status) {
    isLoggedIn.value = status;
  }



  Future<void> login(String username, String password) async {
    try {
      // Gọi phương thức login từ thể hiện authService
      var userData = await authService.login(username, password);
      user.value = User.fromJson(userData);
      setLoginStatus(true); // Đặt trạng thái đăng nhập thành true

    } catch (e) {
      print('Login error: $e');
      setLoginStatus(false); // Đặt trạng thái đăng nhập thành false nếu có lỗi
    }
  }


  // Phương thức đăng ký
// Giả định bạn đã có hàm register trong authService
  Future<void> register(String fullName, String username, String email, String password) async {
    try {
      final response = await authService.register(fullName, username, email, password);

      if (response['success']) {
        // Nếu đăng ký thành công
        print('Đăng ký thành công: ${response['message']}');
        // Xử lý đăng ký thành công (chuyển hướng, hiển thị thông báo, v.v.)
        error.value = "";
      } else {
        // Nếu có lỗi xảy ra
        print('Lỗi: ${response['message']}');
        error.value = response['message'];
        // Hiển thị thông báo lỗi
      }
    } catch (e) {
      print('Lỗi xảy ra khi đăng ký: $e');
      error.value = 'Lỗi xảy ra khi đăng ký: $e';
      // Xử lý lỗi nếu có ngoại lệ
    }
  }



// void logout() {
  //   user.value = User(id: 0, username: '', email: '', password: '', fullname: ''); // Xóa thông tin người dùng
  //   setLoginStatus(false); // Đặt trạng thái đăng nhập thành false
  // }
}
