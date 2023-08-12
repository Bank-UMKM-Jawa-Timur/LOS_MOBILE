import 'dart:convert';

DataPengajuanModel dataPengajuanModelFromJson(String str) =>
    DataPengajuanModel.fromJson(json.decode(str));

String dataPengajuanModelToJson(DataPengajuanModel data) =>
    json.encode(data.toJson());

class DataPengajuanModel {
  String status;
  String message;
  int totalDisetujui;
  int totalDitolak;
  int totalDiproses;
  List<Datum> data;

  DataPengajuanModel({
    required this.status,
    required this.message,
    required this.totalDisetujui,
    required this.totalDitolak,
    required this.totalDiproses,
    required this.data,
  });

  factory DataPengajuanModel.fromJson(Map<String, dynamic> json) =>
      DataPengajuanModel(
        status: json["status"],
        message: json["message"],
        totalDisetujui: json["total_disetujui"],
        totalDitolak: json["total_ditolak"],
        totalDiproses: json["total_diproses"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_disetujui": totalDisetujui,
        "total_ditolak": totalDitolak,
        "total_diproses": totalDiproses,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String kodeC;
  String cabang;
  int disetujui;
  int ditolak;
  int diproses;

  Datum({
    required this.kodeC,
    required this.cabang,
    required this.disetujui,
    required this.ditolak,
    required this.diproses,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeC: json["kodeC"],
        cabang: json["cabang"],
        disetujui: json["disetujui"],
        ditolak: json["ditolak"],
        diproses: json["diproses"],
      );

  Map<String, dynamic> toJson() => {
        "kodeC": kodeC,
        "cabang": cabang,
        "disetujui": disetujui,
        "ditolak": ditolak,
        "diproses": diproses,
      };
}
