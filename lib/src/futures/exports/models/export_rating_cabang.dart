// To parse this JSON data, do
//
//     final ratingCabangModel = ratingCabangModelFromJson(jsonString);

import 'dart:convert';

RatingCabangModel ratingCabangModelFromJson(String str) => RatingCabangModel.fromJson(json.decode(str));

String ratingCabangModelToJson(RatingCabangModel data) => json.encode(data.toJson());

class RatingCabangModel {
    String status;
    String message;
    int totalDisetujui;
    int totalDitolak;
    int totalDiproses;
    Data data;

    RatingCabangModel({
        required this.status,
        required this.message,
        required this.totalDisetujui,
        required this.totalDitolak,
        required this.totalDiproses,
        required this.data,
    });

    factory RatingCabangModel.fromJson(Map<String, dynamic> json) => RatingCabangModel(
        status: json["status"],
        message: json["message"],
        totalDisetujui: json["total_disetujui"],
        totalDitolak: json["total_ditolak"],
        totalDiproses: json["total_diproses"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_disetujui": totalDisetujui,
        "total_ditolak": totalDitolak,
        "total_diproses": totalDiproses,
        "data": data.toJson(),
    };
}

class Data {
    List<Ter> tertinggi;
    List<Ter> terendah;

    Data({
        required this.tertinggi,
        required this.terendah,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tertinggi: List<Ter>.from(json["tertinggi"].map((x) => Ter.fromJson(x))),
        terendah: List<Ter>.from(json["terendah"].map((x) => Ter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tertinggi": List<dynamic>.from(tertinggi.map((x) => x.toJson())),
        "terendah": List<dynamic>.from(terendah.map((x) => x.toJson())),
    };
}

class Ter {
    int total;
    String kodeCabang;
    String cabang;

    Ter({
        required this.total,
        required this.kodeCabang,
        required this.cabang,
    });

    factory Ter.fromJson(Map<String, dynamic> json) => Ter(
        total: json["total"],
        kodeCabang: json["kode_cabang"],
        cabang: json["cabang"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "kode_cabang": kodeCabang,
        "cabang": cabang,
    };
}
