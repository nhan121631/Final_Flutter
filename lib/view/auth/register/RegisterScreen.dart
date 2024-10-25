import 'package:banhang/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../route/app_route.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  // final AuthController authController = Get.find<AuthController>();

  String? usernameError;
  String? nameError;
  String? emailError;
  String? passwordError;
  String? repeatPasswordError;

  String? validateUsername(String value) {
    if (value.isEmpty) return 'Username không được rỗng';
    if (value.length < 6) return 'Username phải dài hơn 6 ký tự';
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value))
      return 'Username không được chứa ký tự đặc biệt';
    return null;
  }

  String? validateFullName(String value) {
    if (value.isEmpty) return 'Full Name không được rỗng';
    if (value.length < 6) return 'Full Name phải dài hơn 6 ký tự';
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email không được rỗng';
    if (!EmailValidator.validate(value)) return 'Email không đúng định dạng';
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Password không được rỗng';
    //if (value.length < 8) return 'Password phải dài hơn 8 ký tự';
    RegExp regex = RegExp(r'^(?=.*?[!@#$%^&*()_+\-=\[\]{};":\\|,.<>\/?]).{8,}$');
    if (!regex.hasMatch(value)) {
      return "Mật khẩu phải có ít nhất 8 ký tự và 1 ký tự đặc biệt";

    }
    return null;
  }

  String? validateRepeatPassword(String value) {
    if (value.isEmpty) return 'Repeat Password không được rỗng';
    if (_passwordController.text != value)
      return 'Password và Repeat Password phải giống nhau';
    return null;
  }

  void register() {
    setState(() {
      usernameError = validateUsername(_usernameController.text);
      nameError = validateFullName(_nameController.text);
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);
      repeatPasswordError = validateRepeatPassword(_repeatPasswordController.text);
    });

    if (usernameError != null || nameError != null || emailError != null || passwordError != null || repeatPasswordError != null) {
      return; // Dừng lại nếu có lỗi
    }

    authController.register(
      _nameController.text,
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    ).then((_) {
      // Sau khi đăng ký thành công hoặc thất bại, hiển thị thông báo
      if (authController.error.value.isEmpty) {
        Get.snackbar(
          'Success',
          'Đăng ký thành công!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          animationDuration: Duration(milliseconds: 250),
        );
      } else {
        Get.snackbar(
          'Register Failed',
          authController.error.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          animationDuration: Duration(milliseconds: 250),

        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 30),
            child: const Text(
              "Create\nAccount",
              style: TextStyle(color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.15),
              child: Column(children: [
                buildTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  errorText: usernameError,
                  validator: validateUsername,
                ),
                const SizedBox(height: 30),

                buildTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  errorText: nameError,
                  validator: validateFullName,
                ),
                const SizedBox(height: 30),

                buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  errorText: emailError,
                  validator: validateEmail,
                ),
                const SizedBox(height: 30),

                buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  errorText: passwordError,
                  validator: validatePassword,
                ),
                const SizedBox(height: 30),

                buildTextField(
                  controller: _repeatPasswordController,
                  hintText: 'Repeat Password',
                  obscureText: true,
                  errorText: repeatPasswordError,
                  validator: validateRepeatPassword,
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: register, // Gọi hàm register
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.login);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white,
                        fontSize: 25),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.fogotpass);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.lightBlue,
                        fontSize: 20),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    bool obscureText = false,
    Function(String)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
          ),
        ),
        if (errorText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                    errorText, style: const TextStyle(color: Colors.red)),
              ),
            ],
          ),
      ],
    );
  }
}
