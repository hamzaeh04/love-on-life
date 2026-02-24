class GetNotificationsModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final NotificationsData? data;

  GetNotificationsModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetNotificationsModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? NotificationsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class NotificationsData {
  final List<NotificationItem>? notifications;
  final Pagination? pagination;
  final int? unreadCount;

  NotificationsData({
    this.notifications,
    this.pagination,
    this.unreadCount,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) {
    return NotificationsData(
      notifications: json['notifications'] != null
          ? List<NotificationItem>.from(
          json['notifications']
              .map((x) => NotificationItem.fromJson(x)))
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      unreadCount: json['unreadCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notifications':
      notifications?.map((x) => x.toJson()).toList(),
      'pagination': pagination?.toJson(),
      'unreadCount': unreadCount,
    };
  }
}

class NotificationItem {
  final String? id;
  final String? userId;
  final String? title;
  final String? body;
  final NotificationMetaData? data;
  bool? isRead;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationItem({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.data,
    this.isRead,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      data: json['data'] != null
          ? NotificationMetaData.fromJson(json['data'])
          : null,
      isRead: json['isRead'],
      type: json['type'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'data': data?.toJson(),
      'isRead': isRead,
      'type': type,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class NotificationMetaData {
  final String? postId;
  final String? type;

  NotificationMetaData({
    this.postId,
    this.type,
  });

  factory NotificationMetaData.fromJson(Map<String, dynamic> json) {
    return NotificationMetaData(
      postId: json['postId'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'type': type,
    };
  }
}

class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPages': totalPages,
    };
  }
}