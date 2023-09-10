import 'dart:convert';

DataCabangModel dataCabangModelFromJson(String str) => DataCabangModel.fromJson(json.decode(str));

String dataCabangModelToJson(DataCabangModel data) => json.encode(data.toJson());

class DataCabangModel {
    List<Datum> data;

    DataCabangModel({
        required this.data,
    });

    factory DataCabangModel.fromJson(Map<String, dynamic> json) => DataCabangModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String kodeCabang;
    String cabang;

    Datum({
        required this.kodeCabang,
        required this.cabang,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeCabang: json["kode_cabang"],
        cabang: json["cabang"],
    );

    Map<String, dynamic> toJson() => {
        "kode_cabang": kodeCabang,
        "cabang": cabang,
    };
}
