import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/profile_menu_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'components/update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left), color: Colors.white,),
        title: const Text("Hồ Sơ",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), // Văn bản tiêu đề
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0), // Padding trực tiếp
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
                      child: const Image(image: AssetImage('assets/images/profile.png')), // Hình ảnh hồ sơ
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
              const Text("Chỉnh Sửa Hồ Sơ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Văn bản tiêu đề
              const Text("Thông tin cá nhân của bạn.", style: TextStyle(fontSize: 16)), // Văn bản phụ
              const SizedBox(height: 20),

              // -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Chỉnh Sửa Hồ Sơ", style: TextStyle(color: Colors.white)), // Văn bản nút
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
                      child: Text("Bạn có chắc chắn muốn đăng xuất không?"), // Văn bản xác nhận
                    ),
                    confirm: Expanded(
                      child: ElevatedButton(
                        // onPressed: () => AuthenticationRepository.instance.logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: BorderSide.none,
                        ),
                        onPressed: () { },
                        child: const Text("Có"), // Văn bản nút xác nhận
                      ),
                    ),
                    cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("Không")), // Văn bản nút hủy
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
