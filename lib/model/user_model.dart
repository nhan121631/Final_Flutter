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

  // Phương thức tĩnh để tạo đối tượng User từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Lấy id từ JSON
      username: json['userName'], // Lấy username từ JSON
      email: json['email'], // Lấy email từ JSON
      password: json['password'], // Lấy password từ JSON
      fullname: json['fullName'], // Lấy fullname từ JSON
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
