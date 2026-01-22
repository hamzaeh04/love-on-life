class GetAllPostModel {
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  GetAllPostModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  GetAllPostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    statusCode = json['statusCode'] as int?;
    message = json['message'] as String?;
    data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['statusCode'] = statusCode;
    json['message'] = message;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Data {
  String? id;
  UserId? userId;
  String? image;
  String? description;
  List<dynamic>? likes;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? isLiked;
  int? likesCount;
  int? commentsCount;

  Data({
    this.id,
    this.userId,
    this.image,
    this.description,
    this.likes,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isLiked,
    this.likesCount,
    this.commentsCount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    userId = (json['userId'] as Map<String,dynamic>?) != null ? UserId.fromJson(json['userId'] as Map<String,dynamic>) : null;
    image = json['image'] as String?;
    description = json['description'] as String?;
    likes = json['likes'] as List?;
    comments = (json['comments'] as List?)?.map((dynamic e) => Comments.fromJson(e as Map<String,dynamic>)).toList();
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    isLiked = json['isLiked'] as bool?;
    likesCount = json['likesCount'] as int?;
    commentsCount = json['commentsCount'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['userId'] = userId?.toJson();
    json['image'] = image;
    json['description'] = description;
    json['likes'] = likes;
    json['comments'] = comments?.map((e) => e.toJson()).toList();
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    json['isLiked'] = isLiked;
    json['likesCount'] = likesCount;
    json['commentsCount'] = commentsCount;
    return json;
  }
}

class UserId {
  String? id;
  String? fullname;
  String? email;
  String? profilePicture;

  UserId({
    this.id,
    this.fullname,
    this.email,
    this.profilePicture,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    fullname = json['fullname'] as String?;
    email = json['email'] as String?;
    profilePicture = json['profilePicture'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['fullname'] = fullname;
    json['email'] = email;
    json['profilePicture'] = profilePicture;
    return json;
  }
}

class Comments {
  UserId? userId;
  String? comment;
  String? id;
  String? createdAt;
  String? updatedAt;

  Comments({
    this.userId,
    this.comment,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Comments.fromJson(Map<String, dynamic> json) {
    userId = (json['userId'] as Map<String,dynamic>?) != null ? UserId.fromJson(json['userId'] as Map<String,dynamic>) : null;
    comment = json['comment'] as String?;
    id = json['_id'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userId'] = userId?.toJson();
    json['comment'] = comment;
    json['_id'] = id;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}

