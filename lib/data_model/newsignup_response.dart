// To parse this JSON data, do
//
//     final newSignupResponse = newSignupResponseFromJson(jsonString);

import 'dart:convert';

NewSignupResponse newSignupResponseFromJson(String str) => NewSignupResponse.fromJson(json.decode(str));

String newSignupResponseToJson(NewSignupResponse data) => json.encode(data.toJson());

class NewSignupResponse {
  NewSignupResponse({
    this.success,
    this.userId,
    this.message,
  });

  bool success;
  int userId;
  String message;

  factory NewSignupResponse.fromJson(Map<String, dynamic> json) => NewSignupResponse(
    success: json["success"],
    userId: json["user_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user_id": userId,
    "message": message,
  };
}

