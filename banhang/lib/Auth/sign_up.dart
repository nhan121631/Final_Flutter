import 'package:flutter/material.dart';
import 'package:banhang/service/api_service.dart'; // Import ApiService

class SignUpPage extends StatefulWidget {
  // Trang đăng ký
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Tạo một key để quản lý form
  final _formKey = GlobalKey<FormState>();

  // Các controller để lấy giá trị từ các trường nhập liệu
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Biến để quản lý trạng thái loading
  bool _isLoading = false;

  @override
  void dispose() {
    // Giải phóng các controller khi widget bị hủy
    _fullnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm kiểm tra email hợp lệ
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    // Sử dụng regex đơn giản để kiểm tra định dạng email
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
            r"[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  // Hàm kiểm tra mật khẩu
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  // Hàm kiểm tra xác nhận mật khẩu
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }
    if (value != _passwordController.text) {
      return 'Mật khẩu không trùng khớp';
    }
    return null;
  }

  // Hàm xử lý khi nhấn nút Đăng Ký
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      // Lấy giá trị từ các trường nhập liệu
      String fullName = _fullnameController.text.trim();
      String username = _usernameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      setState(() {
        _isLoading = true; // Hiển thị loading
      });

      // Gọi hàm register từ ApiService
      Map<String, dynamic> response =
          await ApiService.register(fullName, username, email, password);

      setState(() {
        _isLoading = false; // Ẩn loading
      });

      if (response['success'] == true ||
          response['message'] == 'Registered successfully') {
        // Nếu đăng ký thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thành công')),
        );
        // Reset các trường sau khi đăng ký thành công
        _formKey.currentState!.reset();
      } else {
        // Nếu đăng ký thất bại
        String errorMessage = response['message'] ?? 'Đăng ký thất bại';
        if (response.containsKey('error')) {
          errorMessage += '\n${response['error']}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Ký'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Gắn key vào Form
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Trường Fullname
                TextFormField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    labelText: 'Fullname',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên đầy đủ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Trường Username
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên đăng nhập';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Trường Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 16.0),

                // Trường Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Ẩn mật khẩu
                  validator: _validatePassword,
                ),
                SizedBox(height: 16.0),

                // Trường Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Ẩn mật khẩu
                  validator: _validateConfirmPassword,
                ),
                SizedBox(height: 24.0),

                // Nút Đăng Ký hoặc Loading Indicator
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _submit,
                          child: Text('Đăng Ký'),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
