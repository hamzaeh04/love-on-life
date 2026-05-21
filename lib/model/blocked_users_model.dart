class BlockedUsersModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<BlockedUserData>? data;

  BlockedUsersModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory BlockedUsersModel.fromJson(Map<String, dynamic> json) {
    return BlockedUsersModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<BlockedUserData>.from(
        json['data'].map((x) => BlockedUserData.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class BlockedUserData {
  final String? id;
  final String? fullname;
  final String? email;
  final String? profilePicture;

  BlockedUserData({
    this.id,
    this.fullname,
    this.email,
    this.profilePicture,
  });

  factory BlockedUserData.fromJson(Map<String, dynamic> json) {
    return BlockedUserData(
      id: json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}