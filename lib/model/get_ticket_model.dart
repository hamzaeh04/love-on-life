class GetTicketModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  GetTicketModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  GetTicketModel.fromJson(Map<String, dynamic> json) {
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
  List<Tickets>? tickets;
  int? total;
  int? page;
  int? totalPages;

  Data({
    this.tickets,
    this.total,
    this.page,
    this.totalPages,
  });

  Data.fromJson(Map<String, dynamic> json) {
    tickets = (json['tickets'] as List?)?.map((dynamic e) => Tickets.fromJson(e as Map<String,dynamic>)).toList();
    total = json['total'] as int?;
    page = json['page'] as int?;
    totalPages = json['totalPages'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['tickets'] = tickets?.map((e) => e.toJson()).toList();
    json['total'] = total;
    json['page'] = page;
    json['totalPages'] = totalPages;
    return json;
  }
}

class Tickets {
  String? id;
  String? userId;
  EventId? eventId;
  String? ticketNumber;
  String? status;
  int? price;
  String? createdAt;
  String? updatedAt;
  int? v;

  Tickets({
    this.id,
    this.userId,
    this.eventId,
    this.ticketNumber,
    this.status,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    userId = json['userId'] as String?;
    eventId = (json['eventId'] as Map<String,dynamic>?) != null ? EventId.fromJson(json['eventId'] as Map<String,dynamic>) : null;
    ticketNumber = json['ticketNumber'] as String?;
    status = json['status'] as String?;
    price = json['price'] as int?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['userId'] = userId;
    json['eventId'] = eventId?.toJson();
    json['ticketNumber'] = ticketNumber;
    json['status'] = status;
    json['price'] = price;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}

class EventId {
  String? locationType;
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

  EventId({
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

  EventId.fromJson(Map<String, dynamic> json) {
    if (json['locationType'] is Map) {
      locationType = json['locationType']['type']?.toString();
    } else {
      locationType = json['locationType']?.toString();
    }
    id = json['_id'] as String?;
    userIds = (json['userIds'] as List?)?.map((dynamic e) => e as String).toList();
    image = json['image'] as String?;
    eventTitle = json['eventTitle'] as String?;
    description = json['description'] as String?;
    date = json['date'] as String?;
    time = json['time'] as String?;
    coordinates = (json['coordinates'] as List?)?.map((dynamic e) => (e as num).toDouble()).toList();
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
    return json;
  }
}