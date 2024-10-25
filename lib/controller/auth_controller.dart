import 'package:get/get.dart';
import 'dart:convert';
// import 'package:hive/hive.dart';
import '../model/user_model.dart';
import '../service/remote_service/remote_auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Lấy instance của AuthController

  var isLoggedIn = false.obs;
  var isForgot = false.obs;
  var isSendingCode = true.obs;
  var user = User(id: 0, username: '', email: '', password: '', fullname: '').obs; // Thông tin người dùng
  var error = ''.obs;
  var emailSend=''.obs;

  final AuthService authService = AuthService();

  void setLoginStatus(bool status) {
    isLoggedIn.value = status;
  }

  void setForgotStatus(bool status){
    isForgot.value = status;
  }


// login
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
  Future<void> register(String fullName, String username, String email, String password) async {
    error.value = "";
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
// Phương thức quên mật khẩu
  Future<void> forgotPassword(String email) async {

    error.value = "";
    try {
      final response = await authService.forgotPassword(email);

      if (response['success']) {
        print('Mã đặt lại mật khẩu đã gửi đến email: $email');
        error.value = "";
        emailSend.value = email;
        setForgotStatus(true);
        print('${isForgot}');
      } else {
        print('Lỗi: ${response['message']}');
        setForgotStatus(false);
        error.value = response['message'];
      }
    } catch (e) {
      print('Lỗi xảy ra khi yêu cầu đặt lại mật khẩu: $e');
      setForgotStatus(false);
      error.value = 'Lỗi xảy ra khi yêu cầu đặt lại mật khẩu: $e';
    }
  }

  // Xử lí đặt lại pass
  Future<void> resetPassword(String email, String code, String newPass) async {
    error.value = "";
    try {
      final response = await authService.resetPassword(email, code, newPass);

      if (response['success']) {
        error.value = "";
        print('success: ${error}');
      } else {
        error.value = response['message'];
        print('error: ${error}');
      }
    } catch (e) {
      print('Lỗi xảy ra khi yêu cầu đặt lại mật khẩu: $e');
      setForgotStatus(false);
      error.value = 'Lỗi xảy ra khi yêu cầu đặt lại mật khẩu: $e';
    }
  }

// void logout() {
  //   user.value = User(id: 0, username: '', email: '', password: '', fullname: ''); // Xóa thông tin người dùng
  //   setLoginStatus(false); // Đặt trạng thái đăng nhập thành false
  // }
}
