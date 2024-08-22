class AddAddressResponse {
  int status;
  bool error;
  AddAddressMessages messages;

  AddAddressResponse(
      {required this.status, required this.error, required this.messages});

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) {
    return AddAddressResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? true,
      messages: AddAddressMessages.fromJson(json['messages'] ?? {}),
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

class AddAddressMessages {
  String responsecode;
  String status;

  AddAddressMessages({required this.responsecode, required this.status});

  factory AddAddressMessages.fromJson(Map<String, dynamic> json) {
    return AddAddressMessages(
      responsecode: json['responsecode'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responsecode': responsecode,
      'status': status,
    };
  }
}
