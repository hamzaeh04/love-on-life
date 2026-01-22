class GetAllEventModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  GetAllEventModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  GetAllEventModel.fromJson(Map<String, dynamic> json) {
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
  List<Events>? events;
  int? total;
  int? page;
  int? totalPages;

  Data({
    this.events,
    this.total,
    this.page,
    this.totalPages,
  });

  Data.fromJson(Map<String, dynamic> json) {
    events = (json['events'] as List?)?.map((dynamic e) => Events.fromJson(e as Map<String,dynamic>)).toList();
    total = json['total'] as int?;
    page = json['page'] as int?;
    totalPages = json['totalPages'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['events'] = events?.map((e) => e.toJson()).toList();
    json['total'] = total;
    json['page'] = page;
    json['totalPages'] = totalPages;
    return json;
  }
}

class Events {
  String? locationType;
  String? id;
  List<dynamic>? userIds;
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
  bool? isFavorite;

  Events({
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

  Events.fromJson(Map<String, dynamic> json) {
    locationType = json['locationType'] as String?;
    id = json['_id'] as String?;
    userIds = json['userIds'] as List?;
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
    isFavorite = json['isFavorite'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['locationType'] = locationType;
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
    json['isFavorite'] = isFavorite;
    return json;
  }
}