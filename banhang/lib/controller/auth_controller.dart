import 'package:get/get.dart';
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
      // Gọi phương thức login từ authService
      var userData = await authService.login(username, password);
      user.value = User.fromJson(userData);
      setLoginStatus(true); // Đặt trạng thái đăng nhập thành true
    } catch (e) {
      print('Login error: $e');
      setLoginStatus(false); // Đặt trạng thái đăng nhập thành false nếu có lỗi
      error.value = 'Login error: $e'; // Cập nhật thông báo lỗi
    }
  }

  // Phương thức đăng ký
  Future<void> register(String fullName, String username, String email, String password) async {
    try {
      final response = await authService.register(fullName, username, email, password);

      if (response['success']) {
        // Nếu đăng ký thành công
        print('Đăng ký thành công: ${response['message']}');
        error.value = ""; // Xóa thông báo lỗi nếu có
      } else {
        // Nếu có lỗi xảy ra
        print('Lỗi: ${response['message']}');
        error.value = response['message']; // Cập nhật thông báo lỗi
      }
    } catch (e) {
      print('Lỗi xảy ra khi đăng ký: $e');
      error.value = 'Lỗi xảy ra khi đăng ký: $e'; // Cập nhật thông báo lỗi
    }
  }

  Future<void> updateUser({required int id, required String fullName, required String email}) async {
    try {
      final response = await authService.updateUser(id: id, fullName: fullName, email: email);

      if (response['success']) {
        // Nếu cập nhật thành công
        print('Cập nhật thành công: ${response['message']}');
        User u1 = new User(id: user.value.id,
            username: user.value.username,
            email: email,
            password: user.value.password,
            fullname: fullName);
        user.value = u1;

        //gg
        error.value ="";
        print(user.value.id);
      } else {
        // Nếu có lỗi xảy ra
        print('Lỗi: ${response['message']}');
        error.value = response['message']; // Cập nhật thông báo lỗi
      }
    } catch (e) {
      print('Lỗi xảy ra khi cập nhật: $e');
      error.value = 'Lỗi xảy ra khi cập nhật: $e'; // Cập nhật thông báo lỗi
    }
  }

  void logout() {
    user.value = User(id: 0, username: '', email: '', password: '', fullname: ''); // Xóa thông tin người dùng
    setLoginStatus(false); // Đặt trạng thái đăng nhập thành false
  }
}
