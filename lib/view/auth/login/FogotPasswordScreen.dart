import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../controller/auth_controller.dart'; // Thêm dòng này để import AuthController
import '../../../route/app_route.dart';

class FogotPasswordScreen extends StatelessWidget {
  FogotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController(); // Thêm controller để lấy email

  @override
  Widget build(BuildContext context) {
    bool isTapped=false;
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
              "Forgot\nPassword",
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
                    "Enter your email:",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                TextField(
                  controller: emailController, // Gán controller vào TextField
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email to receive code',
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
                      'Send Code',
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
                        if(!isTapped) {
                          isTapped = true;
                          final email = emailController.text;
                          if (email.isNotEmpty) {
                            await AuthController.instance.forgotPassword(email);

                            if (AuthController.instance.isForgot.value) {
                              Get.snackbar('Receive Code Failed',
                                'Verification code sent successfully',
                                duration: const Duration(seconds: 3),);
                              Get.toNamed('${AppRoute.fogotpass}${AppRoute
                                  .acceptcode}');
                              print("success");
                            } else {
                              Get.snackbar(
                                'Receiving code failed', 'Invalid Email',
                                duration: const Duration(seconds: 2),);
                            }
                          } else {
                            Get.snackbar("Error",
                                "Please enter your email"); // Thông báo lỗi nếu email rỗng
                          }
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
