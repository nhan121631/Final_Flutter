import 'package:banhang/controller/controllers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controller/auth_controller.dart';
import '../../../route/app_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());

  // Tạo controller cho email và mật khẩu
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Giải phóng tài nguyên khi widget bị hủy
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33, fontWeight: FontWeight.w500),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          FocusScope.of(context).unfocus(); // Ẩn bàn phím

                          String email = usernameController.text.trim();
                          String password = passwordController.text.trim();

                          // Kiểm tra đầu vào
                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar(
                              'Input Error',
                              'Please enter both username and password',
                              duration: const Duration(seconds: 2), // Đặt thời gian hiển thị là 2 giây
                            );
                            return;
                          }

                          await authController.login(email, password);

                          if (authController.isLoggedIn.value) {
                            Get.toNamed(AppRoute.dashboard);
                            print("success");
                          } else {
                            Get.snackbar('Login Failed', 'Invalid username or password',
                              duration: const Duration(seconds: 2),);
                          }
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.register);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: Color(0xff4c505b),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.forgotpass); // Điều hướng đến màn hình quên mật khẩu
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: Color(0xff4c505b),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
