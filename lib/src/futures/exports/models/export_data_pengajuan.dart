import 'dart:convert';

DataPengajuanModel dataPengajuanModelFromJson(String str) =>
    DataPengajuanModel.fromJson(json.decode(str));

String dataPengajuanModelToJson(DataPengajuanModel data) =>
    json.encode(data.toJson());

class DataPengajuanModel {
  String status;
  String message;
  List<Datum> data;

  DataPengajuanModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DataPengajuanModel.fromJson(Map<String, dynamic> json) =>
      DataPengajuanModel(
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
  String totalDisetujui;
  String totalDitolak;
  String totalDiproses;

  Datum({
    required this.kodeC,
    required this.cabang,
    required this.totalDisetujui,
    required this.totalDitolak,
    required this.totalDiproses,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeC: json["kodeC"],
        cabang: json["cabang"],
        totalDisetujui: json["total_disetujui"],
        totalDitolak: json["total_ditolak"],
        totalDiproses: json["total_diproses"],
      );

  Map<String, dynamic> toJson() => {
        "kodeC": kodeC,
        "cabang": cabang,
        "total_disetujui": totalDisetujui,
        "total_ditolak": totalDitolak,
        "total_diproses": totalDiproses,
      };
}
