import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Chỉnh Sửa Hồ Sơ", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Văn bản tiêu đề
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0), // Padding trực tiếp
          child: Column(
            children: [
              // -- IMAGE with ICON
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
                      child: const Icon(LineAwesomeIcons.camera, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Họ Tên"), // Văn bản nhãn
                        prefixIcon: const Icon(LineAwesomeIcons.user),
                      ),
                    ),
                    const SizedBox(height: 20), // Kích thước cố định
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Email"), // Văn bản nhãn
                        prefixIcon: const Icon(LineAwesomeIcons.envelope_1),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Số Điện Thoại"), // Văn bản nhãn
                        prefixIcon: const Icon(LineAwesomeIcons.phone),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("Mật Khẩu"), // Văn bản nhãn
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                          icon: const Icon(LineAwesomeIcons.eye_slash),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const UpdateProfileScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Chỉnh Sửa Hồ Sơ", style: TextStyle(color: Colors.white)), // Văn bản nút
                      ),
                    ),
                    const SizedBox(height: 40),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: "Tham Gia", // Văn bản tham gia
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                text: " 01/01/2023", // Văn bản ngày tham gia
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                          ),
                          child: const Text("Xóa Tài Khoản"), // Văn bản nút xóa
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
