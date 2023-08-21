import 'dart:convert';

LoginTypeNullModel loginTypeNullModelFromJson(String str) =>
    LoginTypeNullModel.fromJson(json.decode(str));

String loginTypeNullModelToJson(LoginTypeNullModel data) =>
    json.encode(data.toJson());

class LoginTypeNullModel {
  String status;
  String message;
  int id;
  String email;
  String role;
  String accessToken;
  String tokenType;
  Data data;

  LoginTypeNullModel({
    required this.status,
    required this.message,
    required this.id,
    required this.email,
    required this.role,
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  factory LoginTypeNullModel.fromJson(Map<String, dynamic> json) =>
      LoginTypeNullModel(
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
  dynamic nip;
  String nama;
  dynamic jabatan;
  dynamic namaJabatan;
  dynamic entitas;
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
        jabatan: json["jabatan"],
        namaJabatan: json["nama_jabatan"],
        entitas: json["entitas"],
        bagian: json["bagian"],
      );

  Map<String, dynamic> toJson() => {
        "nip": nip,
        "nama": nama,
        "jabatan": jabatan,
        "nama_jabatan": namaJabatan,
        "entitas": entitas,
        "bagian": bagian,
      };
}
