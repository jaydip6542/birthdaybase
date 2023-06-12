import 'dart:convert';

OrderDeleteResponse orderDeleteResponseFromJson(String str) => OrderDeleteResponse.fromJson(json.decode(str));

String orderDeleteResponseToJson(OrderDeleteResponse data) => json.encode(data.toJson());

class OrderDeleteResponse {
  OrderDeleteResponse({
    this.data,
    this.success,
    this.status,
  });

  List<dynamic> data;
  bool success;
  int status;

  factory OrderDeleteResponse.fromJson(Map<String, dynamic> json) => OrderDeleteResponse(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "success": success,
    "status": status,
  };
}
