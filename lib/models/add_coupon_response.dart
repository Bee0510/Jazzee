class CouponResponse {
  final int status;
  final bool error;
  final CouponMessage messages;

  CouponResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? true,
      messages: CouponMessage.fromJson(json['messages'] ?? {}),
    );
  }
}

class CouponMessage {
  final String responsecode;
  final String status;

  CouponMessage({
    required this.responsecode,
    required this.status,
  });

  factory CouponMessage.fromJson(Map<String, dynamic> json) {
    return CouponMessage(
      responsecode: json['responsecode'] ?? "",
      status: json['status'] ?? "",
    );
  }
}
