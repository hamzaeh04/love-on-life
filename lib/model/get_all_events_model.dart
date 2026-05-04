class GetAllEventModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final EventData? data;

  GetAllEventModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetAllEventModel.fromJson(Map<String, dynamic> json) {
    return GetAllEventModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] != null && json['data'] is Map<String, dynamic>) 
          ? EventData.fromJson(json['data']) 
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

class EventData {
  final List<Event>? events;
  final int? total;
  final int? page;
  final int? totalPages;

  EventData({
    this.events,
    this.total,
    this.page,
    this.totalPages,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      events: json['events'] != null
          ? List<Event>.from(
        json['events'].map((x) => Event.fromJson(x)),
      )
          : [],
      total: json['total'],
      page: json['page'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'events': events?.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'totalPages': totalPages,
    };
  }
}

class Event {
  final LocationType? locationType;
  final String? id;
  final List<dynamic>? userIds;
  final String? image;
  final String? eventTitle;
  final String? description;
  final DateTime? date;
  final String? time;
  final List<double>? coordinates;
  final String? category;
  final String? ticketType;
  final int? price;
  final String? eventStatus;
  final bool? isEnable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  bool? isFavorite;

  Event({
    this.locationType,
    this.id,
    this.userIds,
    this.image,
    this.eventTitle,
    this.description,
    this.date,
    this.time,
    this.coordinates,
    this.category,
    this.ticketType,
    this.price,
    this.eventStatus,
    this.isEnable,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isFavorite,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      locationType: json['locationType'] != null
          ? LocationType.fromJson(json['locationType'])
          : null,
      id: json['_id'],
      userIds: json['userIds'] != null
          ? List<dynamic>.from(json['userIds'])
          : [],
      image: json['image'],
      eventTitle: json['eventTitle'],
      description: json['description'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      time: json['time'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(
        json['coordinates'].map((x) => (x as num).toDouble()),
      )
          : [],
      category: json['category'],
      ticketType: json['ticketType'],
      price: json['price'],
      eventStatus: json['eventStatus'],
      isEnable: json['isEnable'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      v: json['__v'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationType': locationType?.toJson(),
      '_id': id,
      'userIds': userIds,
      'image': image,
      'eventTitle': eventTitle,
      'description': description,
      'date': date?.toIso8601String(),
      'time': time,
      'coordinates': coordinates,
      'category': category,
      'ticketType': ticketType,
      'price': price,
      'eventStatus': eventStatus,
      'isEnable': isEnable,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'isFavorite': isFavorite,
    };
  }
}

class LocationType {
  final String? type;

  LocationType({this.type});

  factory LocationType.fromJson(dynamic json) {
    if (json is String) {
      return LocationType(type: json);
    }
    if (json is Map<String, dynamic>) {
      return LocationType(
        type: json['type'],
      );
    }
    return LocationType();
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}