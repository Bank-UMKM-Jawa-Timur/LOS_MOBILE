import 'dart:convert';

SkemaKreditModel skemaKreditModelFromJson(String str) =>
    SkemaKreditModel.fromJson(json.decode(str));

String skemaKreditModelToJson(SkemaKreditModel data) =>
    json.encode(data.toJson());

class SkemaKreditModel {
  String status;
  String message;
  List<Datum> data;

  SkemaKreditModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SkemaKreditModel.fromJson(Map<String, dynamic> json) =>
      SkemaKreditModel(
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
  String kodeCabang;
  String cabang;
  String pkpj;
  String kkb;
  String umroh;
  String prokesra;
  String kusuma;

  Datum({
    required this.kodeCabang,
    required this.cabang,
    required this.pkpj,
    required this.kkb,
    required this.umroh,
    required this.prokesra,
    required this.kusuma,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeCabang: json["kode_cabang"],
        cabang: json["cabang"],
        pkpj: json["PKPJ"],
        kkb: json["KKB"],
        umroh: json["Umroh"],
        prokesra: json["Prokesra"],
        kusuma: json["Kusuma"],
      );

  Map<String, dynamic> toJson() => {
        "kode_cabang": kodeCabang,
        "cabang": cabang,
        "PKPJ": pkpj,
        "KKB": kkb,
        "Umroh": umroh,
        "Prokesra": prokesra,
        "Kusuma": kusuma,
      };
}
