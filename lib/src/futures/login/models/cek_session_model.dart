import 'dart:convert';

CekSessionModel cekSessionModelFromJson(String str) =>
    CekSessionModel.fromJson(json.decode(str));

String cekSessionModelToJson(CekSessionModel data) =>
    json.encode(data.toJson());

class CekSessionModel {
  String status;
  String message;

  CekSessionModel({
    required this.status,
    required this.message,
  });

  factory CekSessionModel.fromJson(Map<String, dynamic> json) =>
      CekSessionModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
