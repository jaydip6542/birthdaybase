// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  bool result;
  String message;
  String accessToken;
  String tokenType;
  dynamic expiresAt;
  User user;

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    result: json["result"],
    message: json["message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresAt: json["expires_at"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_at": expiresAt,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.phone,
  });

  int id;
  String type;
  String name;
  dynamic email;
  dynamic avatar;
  String avatarOriginal;
  String phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "email": email,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "phone": phone,
  };
}
