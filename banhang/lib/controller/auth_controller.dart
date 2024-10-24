import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/user_model.dart';
import '../service/remote_service/remote_auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Lấy instance của AuthController

  var isLoggedIn = false.obs;
  var user = User(id: 0, username: '', email: '', password: '', fullname: '').obs; // Thông tin người dùng
  final AuthService authService = AuthService();

  void setLoginStatus(bool status) {
    isLoggedIn.value = status;
  }

  Future<void> login(String username, String password) async {
    try {
      // Gọi phương thức login từ thể hiện authService
      var userData = await authService.login(username, password);
      user.value = User.fromJson(userData);
      saveUser(user.value);
      //setLoginStatus(true); // Đặt trạng thái đăng nhập thành true

    } catch (e) {
      print('Login error: $e');
      setLoginStatus(false); // Đặt trạng thái đăng nhập thành false nếu có lỗi
    }
  }
  void saveUser(User user) async {
    var box = await Hive.openBox<User>('userBox');
    await box.put('currentUser', user);
  }


// void logout() {
  //   user.value = User(id: 0, username: '', email: '', password: '', fullname: ''); // Xóa thông tin người dùng
  //   setLoginStatus(false); // Đặt trạng thái đăng nhập thành false
  // }
}
