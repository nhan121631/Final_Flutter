import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/controllers.dart';
import '../../../route/app_route.dart';

class AcceptCodeScreen extends StatelessWidget {
  AcceptCodeScreen({super.key});

  final TextEditingController passController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Fogot\nPassword",
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 5, bottom: 6),
                  child: const Text(
                    "Enter code:",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                TextField(
                  controller: codeController,
                  keyboardType: TextInputType.number, // Chỉ cho nhập số
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép ký tự số
                  ],
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Enter Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 5, bottom: 6),
                  child: const Text(
                    "Enter new Password:",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 5, bottom: 6),
                  child: const Text(
                    "Enter Repeat Password:",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                TextField(
                  controller: repeatPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          /*Get.toNamed(AppRoute.login);*/
                          final code = codeController.text;
                          final pass = passController.text;
                          final passRepeat = repeatPassController.text;
                          if(code.isEmpty || pass.isEmpty || passRepeat.isEmpty){
                            Get.snackbar("Fail", "Điền thiếu thông tin");
                            return;
                          }
                          // Kiểm tra mật khẩu
                          RegExp regex = RegExp(r'^(?=.*?[!@#$%^&*()_+\-=\[\]{};":\\|,.<>\/?]).{8,}$');
                          if (!regex.hasMatch(pass)) {
                            Get.snackbar("Fail", "Mật khẩu phải có ít nhất 8 ký tự và 1 ký tự đặc biệt");
                            return;
                          }

                          if (pass != passRepeat) {
                            Get.snackbar("Fail", "Mật khẩu không khớp");
                            return;
                          }
                          await AuthController.instance.resetPassword(authController.emailSend.value, code, pass);
                          print("Giá trị lỗi trước khi kiểm tra: ${authController.error.value}");

                          if (AuthController.instance.error.value.isEmpty) {
                            Get.snackbar("Successfully", "Đổi mật khẩu thành công");
                            Get.toNamed(AppRoute.login);
                          } else {
                            Get.snackbar("Fail", "${authController.error.value}");
                          }


                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, 'register');
                          Get.toNamed(AppRoute.login);
                        },
                        child: const Text(
                          'Back to login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}