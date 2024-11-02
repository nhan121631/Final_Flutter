class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final String fullname; // Sửa lại kiểu dữ liệu từ double sang String

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.fullname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      fullname: json['fullName'] ?? '',
    );
  }

  // Phương thức chuyển đổi đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': username,
      'email': email,
      'password': password,
      'fullName': fullname,
    };
  }
}
