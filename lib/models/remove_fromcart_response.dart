class removeFromCartResponse {
  int status;
  bool error;
  removeFromCartResponseMessage messages;

  removeFromCartResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory removeFromCartResponse.fromJson(Map<String, dynamic> json) {
    return removeFromCartResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: removeFromCartResponseMessage.fromJson(json['messages'] ?? {}),
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

class removeFromCartResponseMessage {
  String responseCode;
  String status;

  removeFromCartResponseMessage({
    required this.responseCode,
    required this.status,
  });

  factory removeFromCartResponseMessage.fromJson(Map<String, dynamic> json) {
    return removeFromCartResponseMessage(
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
