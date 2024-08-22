class CheckoutResponse {
  final int status;
  final bool error;
  final CheckoutMessage messages;

  CheckoutResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: CheckoutMessage.fromJson(json['messages'] ?? {}),
    );
  }
}

class CheckoutMessage {
  final String responsecode;
  final String status;

  CheckoutMessage({
    required this.responsecode,
    required this.status,
  });

  factory CheckoutMessage.fromJson(Map<String, dynamic> json) {
    return CheckoutMessage(
      responsecode: json['responsecode'] ?? "",
      status: json['status'] ?? "",
    );
  }
}
