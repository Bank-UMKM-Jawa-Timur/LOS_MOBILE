import 'dart:convert';

PosisiPengajuanModel posisiPengajuanModelFromJson(String str) =>
    PosisiPengajuanModel.fromJson(json.decode(str));

String posisiPengajuanModelToJson(PosisiPengajuanModel data) =>
    json.encode(data.toJson());

class PosisiPengajuanModel {
  String status;
  String message;
  List<Datum> data;

  PosisiPengajuanModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PosisiPengajuanModel.fromJson(Map<String, dynamic> json) =>
      PosisiPengajuanModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String kodeC;
  String cabang;
  int pincab;
  int pbp;
  int pbo;
  int penyelia;
  int staff;

  Datum({
    required this.kodeC,
    required this.cabang,
    required this.pincab,
    required this.pbp,
    required this.pbo,
    required this.penyelia,
    required this.staff,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeC: json["kodeC"],
        cabang: json["cabang"],
        pincab: json["pincab"],
        pbp: json["pbp"],
        pbo: json["pbo"],
        penyelia: json["penyelia"],
        staff: json["staff"],
      );

  Map<String, dynamic> toJson() => {
        "kodeC": kodeC,
        "cabang": cabang,
        "pincab": pincab,
        "pbp": pbp,
        "pbo": pbo,
        "penyelia": penyelia,
        "staff": staff,
      };
}
