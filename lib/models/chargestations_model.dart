class ChargestationsModel {
  String stationId;
  String? tenantId;
  String? chargePointId;
  double? longitude;
  double? latitude;
  String? status;
  List<Connectors>? connectors;
  ImageUrls? imageUrls;

  ChargestationsModel(
      {required this.stationId,
      this.tenantId,
      this.chargePointId,
      this.longitude,
      this.latitude,
      this.status,
      this.connectors,
      this.imageUrls});

  factory ChargestationsModel.fromJson(Map<String, dynamic> json) =>
      ChargestationsModel(
        stationId: json['stationId'] as String,
        tenantId: json['tenantId'] == null ? null : json['tenantId'] as String?,
        chargePointId: json['chargePointId'] == null
            ? null
            : json['chargePointId'] as String?,
        longitude:
            json['longitude'] == null ? null : json['longitude'] as double?,
        latitude: json['latitude'] == null ? null : json['latitude'] as double?,
        status: json['status'] == null
            ? null
            : (json['status'] as String).toLowerCase(),
        imageUrls: json['imageUrls'] != null
            ? ImageUrls.fromJson(json['imageUrls'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationId'] = stationId;
    data['tenantId'] = tenantId;
    data['chargePointId'] = chargePointId;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['status'] = status;
    if (connectors != null) {
      data['connectors'] = connectors!.map((v) => v.toJson()).toList();
    }
    if (imageUrls != null) {
      data['imageUrls'] = imageUrls!.toJson();
    }
    return data;
  }
}

enum Status { busy, available, offline, unknown }

Status getStatus(String? status) {
  Status result;
  switch (status) {
    case 'available':
      result = Status.available;
      break;
    case 'busy':
      result = Status.busy;
      break;
    case 'offline':
      result = Status.offline;
      break;
    default:
      result = Status.unknown;
      break;
  }
  return result;
}

class Connectors {
  String? id;
  String? type;
  int? connectorId;
  double? power;
  bool? enabled;
  double? tariff;

  Connectors(
      {this.id,
      this.type,
      this.connectorId,
      this.power,
      this.enabled,
      this.tariff});

  Connectors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    connectorId = json['connectorId'];
    power = json['power'];
    enabled = json['enabled'];
    tariff = json['tariff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['connectorId'] = connectorId;
    data['power'] = power;
    data['enabled'] = enabled;
    data['tariff'] = tariff;
    return data;
  }
}

class ImageUrls {
  List<String>? l160;
  List<String>? l432;
  List<String>? l1024;

  ImageUrls({this.l160, this.l432, this.l1024});

  ImageUrls.fromJson(Map<String, dynamic> json) {
    l160 = json['160'].cast<String>();
    l432 = json['432'].cast<String>();
    l1024 = json['1024'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['160'] = l160;
    data['432'] = l432;
    data['1024'] = l1024;
    return data;
  }
}
