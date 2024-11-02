import 'package:banhang/model/user_model.dart';

class Review {
  final int id;
  final User user;
  final int star;
  final String comment;
  final DateTime? createdDate;
  final DateTime? modifiedDate;

  Review({
    required this.id,
    required this.user,
    required this.star,
    required this.comment,
    this.createdDate,
    this.modifiedDate,
  });

  // Phương thức fromJson để chuyển đổi JSON sang đối tượng Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user: User.fromJson(json['user']),
      star: json['star'],
      comment: json['comment'],
      createdDate: json['createdDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdDate'])
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['modifiedDate'])
          : null,
    );
  }

  // Phương thức toJson để chuyển đối tượng Review thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'star': star,
      'comment': comment,
      'createdDate': createdDate?.toIso8601String(),
      'modifiedDate': modifiedDate?.toIso8601String(),
    };
  }
}
