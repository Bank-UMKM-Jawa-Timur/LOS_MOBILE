import 'dart:convert';

LoginAdminModel loginAdminModelFromJson(String str) =>
    LoginAdminModel.fromJson(json.decode(str));

String loginAdminModelToJson(LoginAdminModel data) =>
    json.encode(data.toJson());

class LoginAdminModel {
  String status;
  String message;
  int id;
  String email;
  String role;
  String accessToken;
  String tokenType;
  Data data;

  LoginAdminModel({
    required this.status,
    required this.message,
    required this.id,
    required this.email,
    required this.role,
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  factory LoginAdminModel.fromJson(Map<String, dynamic> json) =>
      LoginAdminModel(
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

  Entitas({
    required this.type,
  });

  factory Entitas.fromJson(Map<String, dynamic> json) => Entitas(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
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
