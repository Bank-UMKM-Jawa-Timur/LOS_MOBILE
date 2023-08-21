import 'dart:convert';

LoginEntitasTypeTwoModel loginEntitasTypeTwoModelFromJson(String str) =>
    LoginEntitasTypeTwoModel.fromJson(json.decode(str));

String loginEntitasTypeTwoModelToJson(LoginEntitasTypeTwoModel data) =>
    json.encode(data.toJson());

class LoginEntitasTypeTwoModel {
  String status;
  String message;
  int id;
  String email;
  String role;
  String accessToken;
  String tokenType;
  Data data;

  LoginEntitasTypeTwoModel({
    required this.status,
    required this.message,
    required this.id,
    required this.email,
    required this.role,
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  factory LoginEntitasTypeTwoModel.fromJson(Map<String, dynamic> json) =>
      LoginEntitasTypeTwoModel(
        status: json["status"],
        message: json["message"],
        id: json["id"],
        email: json["email"],
        role: json["role"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "id": id,
        "email": email,
        "role": role,
        "access_token": accessToken,
        "token_type": tokenType,
        "data": data.toJson(),
      };
}

class Data {
  String nip;
  String nama;
  Jabatan jabatan;
  String namaJabatan;
  Entitas entitas;
  dynamic bagian;

  Data({
    required this.nip,
    required this.nama,
    required this.jabatan,
    required this.namaJabatan,
    required this.entitas,
    required this.bagian,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nip: json["nip"],
        nama: json["nama"],
        jabatan: Jabatan.fromJson(json["jabatan"]),
        namaJabatan: json["nama_jabatan"],
        entitas: Entitas.fromJson(json["entitas"]),
        bagian: json["bagian"],
      );

  Map<String, dynamic> toJson() => {
        "nip": nip,
        "nama": nama,
        "jabatan": jabatan.toJson(),
        "nama_jabatan": namaJabatan,
        "entitas": entitas.toJson(),
        "bagian": bagian,
      };
}

class Entitas {
  int type;
  Cab cab;

  Entitas({
    required this.type,
    required this.cab,
  });

  factory Entitas.fromJson(Map<String, dynamic> json) => Entitas(
        type: json["type"],
        cab: Cab.fromJson(json["cab"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "cab": cab.toJson(),
      };
}

class Cab {
  String kdCabang;
  String namaCabang;
  String alamatCabang;
  int idKantor;
  DateTime createdAt;
  dynamic updatedAt;

  Cab({
    required this.kdCabang,
    required this.namaCabang,
    required this.alamatCabang,
    required this.idKantor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cab.fromJson(Map<String, dynamic> json) => Cab(
        kdCabang: json["kd_cabang"],
        namaCabang: json["nama_cabang"],
        alamatCabang: json["alamat_cabang"],
        idKantor: json["id_kantor"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "kd_cabang": kdCabang,
        "nama_cabang": namaCabang,
        "alamat_cabang": alamatCabang,
        "id_kantor": idKantor,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}

class Jabatan {
  String kdJabatan;
  String namaJabatan;
  DateTime createdAt;
  dynamic updatedAt;

  Jabatan({
    required this.kdJabatan,
    required this.namaJabatan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) => Jabatan(
        kdJabatan: json["kd_jabatan"],
        namaJabatan: json["nama_jabatan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "kd_jabatan": kdJabatan,
        "nama_jabatan": namaJabatan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
