import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controllers.dart';
import '../../route/app_route.dart';
import 'components/profile_menu_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 48), // Ẩn nút leading
            const Expanded(
              child: Center(
                child: Text(
                  "Hồ Sơ",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: cartController.itemCart,
              builder: (context, itemCount, child) {
                return badges.Badge(
                  badgeContent: Text(
                    "$itemCount",
                    style: const TextStyle(color: Colors.black),
                  ),
                  badgeStyle: BadgeStyle(
                    badgeColor: Theme.of(context).cardColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      cartController.loadCart();
                      Get.toNamed(AppRoute.cart);
                    },
                    child: Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage('assets/images/profile.jpg')),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Hiển thị tên người dùng từ profileController
              Obx(() => Text(
                authController.user.value.fullname,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),

              // Hiển thị ID người dùng từ profileController
              Obx(() => Text(
                "Mã người dùng: @${authController.user.value.id}", // ID người dùng
                style: const TextStyle(fontSize: 16),
              )),

              const SizedBox(height: 20),

              // -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Chỉnh Sửa Hồ Sơ", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              // -- MENU
              ProfileMenuWidget(title: "Cài Đặt", icon: LineAwesomeIcons.cog, onPress: () {}),
              ProfileMenuWidget(title: "Chi Tiết Thanh Toán", icon: LineAwesomeIcons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "Quản Lý Người Dùng", icon: LineAwesomeIcons.user_check, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Thông Tin", icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(
                title: "Đăng Xuất",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "ĐĂNG XUẤT",
                    titleStyle: const TextStyle(fontSize: 20),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Bạn có chắc chắn muốn đăng xuất không?"),
                    ),
                    confirm: Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: BorderSide.none,
                        ),
                        onPressed: () {
                          authController.logout();
                          Get.toNamed(AppRoute.login);
                        },
                        child: const Text("Có"),
                      ),
                    ),
                    cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("Không")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
