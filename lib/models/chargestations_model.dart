// Generated by https://quicktype.io
//
// To change quicktype's target language, run command:
//
//   "Set quicktype target language"

class ChargestationsModel {
  String stationId;
  String tenantId;
  String chargePointId;
  double longitude;
  double latitude;
  Status status;

  ChargestationsModel({
    required this.stationId,
    required this.tenantId,
    required this.chargePointId,
    required this.longitude,
    required this.latitude,
    required this.status,
  });
}

enum Status { BUSY, AVAILABLE, OFFLINE }
