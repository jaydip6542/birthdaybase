// To parse this JSON data, do
//
//     final businessSetingResponse = businessSetingResponseFromJson(jsonString);

import 'dart:convert';

BusinessSetingResponse businessSetingResponseFromJson(String str) => BusinessSetingResponse.fromJson(json.decode(str));

String businessSetingResponseToJson(BusinessSetingResponse data) => json.encode(data.toJson());

class BusinessSetingResponse {
  BusinessSetingResponse({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory BusinessSetingResponse.fromJson(Map<String, dynamic> json) => BusinessSetingResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Datum {
  Datum({
    this.type,
    this.value,
  });

  String type;
  dynamic value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

class ValueElement {
  ValueElement({
    this.type,
    this.label,
  });

  String type;
  String label;

  factory ValueElement.fromJson(Map<String, dynamic> json) => ValueElement(
    type: json["type"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "label": label,
  };
}
