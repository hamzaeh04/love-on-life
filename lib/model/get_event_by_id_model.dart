class GetEventByIdModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  GetEventByIdModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  GetEventByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    statusCode = json['statusCode'] as int?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['statusCode'] = statusCode;
    json['message'] = message;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  LocationType? locationType;
  String? id;
  List<String>? userIds;
  String? image;
  String? eventTitle;
  String? description;
  String? date;
  String? time;
  List<double>? coordinates;
  String? category;
  String? ticketType;
  int? price;
  String? eventStatus;
  bool? isEnable;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data({
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
  });

  Data.fromJson(Map<String, dynamic> json) {
    locationType = (json['locationType'] as Map<String,dynamic>?) != null ? LocationType.fromJson(json['locationType'] as Map<String,dynamic>) : null;
    id = json['_id'] as String?;
    userIds = (json['userIds'] as List?)?.map((dynamic e) => e as String).toList();
    image = json['image'] as String?;
    eventTitle = json['eventTitle'] as String?;
    description = json['description'] as String?;
    date = json['date'] as String?;
    time = json['time'] as String?;
    coordinates = (json['coordinates'] as List?)?.map((dynamic e) => e as double).toList();
    category = json['category'] as String?;
    ticketType = json['ticketType'] as String?;
    price = json['price'] as int?;
    eventStatus = json['eventStatus'] as String?;
    isEnable = json['isEnable'] as bool?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['locationType'] = locationType?.toJson();
    json['_id'] = id;
    json['userIds'] = userIds;
    json['image'] = image;
    json['eventTitle'] = eventTitle;
    json['description'] = description;
    json['date'] = date;
    json['time'] = time;
    json['coordinates'] = coordinates;
    json['category'] = category;
    json['ticketType'] = ticketType;
    json['price'] = price;
    json['eventStatus'] = eventStatus;
    json['isEnable'] = isEnable;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}

class LocationType {
  String? type;

  LocationType({
    this.type,
  });

  LocationType.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['type'] = type;
    return json;
  }
}