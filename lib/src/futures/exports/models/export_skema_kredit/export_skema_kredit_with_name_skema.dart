import 'dart:convert';

SkemaKreditWithNameSkemaModel skemaKreditWithNameSkemaModelFromJson(
        String str) =>
    SkemaKreditWithNameSkemaModel.fromJson(json.decode(str));

String skemaKreditWithNameSkemaModelToJson(
        SkemaKreditWithNameSkemaModel data) =>
    json.encode(data.toJson());

class SkemaKreditWithNameSkemaModel {
  String status;
  String message;
  List<Datum> data;
  Ranking ranking;

  SkemaKreditWithNameSkemaModel({
    required this.status,
    required this.message,
    required this.data,
    required this.ranking,
  });

  factory SkemaKreditWithNameSkemaModel.fromJson(Map<String, dynamic> json) =>
      SkemaKreditWithNameSkemaModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        ranking: Ranking.fromJson(json["ranking"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "ranking": ranking.toJson(),
      };
}

class Datum {
  String kodeCabang;
  String cabang;
  int total;
  String totalDisetujui;
  String totalDitolak;
  String posisiPincab;
  String posisiPbp;
  String posisiPbo;
  String posisiPenyelia;
  String posisiStaf;

  Datum({
    required this.kodeCabang,
    required this.cabang,
    required this.total,
    required this.totalDisetujui,
    required this.totalDitolak,
    required this.posisiPincab,
    required this.posisiPbp,
    required this.posisiPbo,
    required this.posisiPenyelia,
    required this.posisiStaf,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeCabang: json["kode_cabang"],
        cabang: json["cabang"],
        total: json["total"],
        totalDisetujui: json["total_disetujui"],
        totalDitolak: json["total_ditolak"],
        posisiPincab: json["posisi_pincab"],
        posisiPbp: json["posisi_pbp"],
        posisiPbo: json["posisi_pbo"],
        posisiPenyelia: json["posisi_penyelia"],
        posisiStaf: json["posisi_staf"],
      );

  Map<String, dynamic> toJson() => {
        "kode_cabang": kodeCabang,
        "cabang": cabang,
        "total": total,
        "total_disetujui": totalDisetujui,
        "total_ditolak": totalDitolak,
        "posisi_pincab": posisiPincab,
        "posisi_pbp": posisiPbp,
        "posisi_pbo": posisiPbo,
        "posisi_penyelia": posisiPenyelia,
        "posisi_staf": posisiStaf,
      };
}

class Ranking {
  List<Ter> tertinggi;
  List<Ter> terendah;

  Ranking({
    required this.tertinggi,
    required this.terendah,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
        tertinggi:
            List<Ter>.from(json["tertinggi"].map((x) => Ter.fromJson(x))),
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
