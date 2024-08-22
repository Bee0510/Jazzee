class addToCartResponse {
  int status;
  bool error;
  addToCartResponseMessage messages;

  addToCartResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory addToCartResponse.fromJson(Map<String, dynamic> json) {
    return addToCartResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: addToCartResponseMessage.fromJson(json['messages'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': error,
      'messages': messages.toJson(),
    };
  }
}

class addToCartResponseMessage {
  String responseCode;
  String status;

  addToCartResponseMessage({
    required this.responseCode,
    required this.status,
  });

  factory addToCartResponseMessage.fromJson(Map<String, dynamic> json) {
    return addToCartResponseMessage(
      responseCode: json['responsecode'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responsecode': responseCode,
      'status': status,
    };
  }
}
