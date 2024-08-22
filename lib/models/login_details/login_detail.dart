class login_detail {
  final int status;
  final bool error;
  final OtpMessages messages;

  login_detail({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory login_detail.fromJson(Map<String, dynamic> json) {
    return login_detail(
      status: json['status'],
      error: json['error'],
      messages: OtpMessages.fromJson(json['messages']),
    );
  }
}

class OtpMessages {
  final String responsecode;
  final OtpStatus status;

  OtpMessages({
    required this.responsecode,
    required this.status,
  });

  factory OtpMessages.fromJson(Map<String, dynamic> json) {
    return OtpMessages(
      responsecode: json['responsecode'],
      status: OtpStatus.fromJson(json['status']),
    );
  }
}

class OtpStatus {
  final String contactOtp;
  final int loginOtp;

  OtpStatus({
    required this.contactOtp,
    required this.loginOtp,
  });

  factory OtpStatus.fromJson(Map<String, dynamic> json) {
    return OtpStatus(
      contactOtp: json['contact_otp'],
      loginOtp: json['login_otp'],
    );
  }
}
