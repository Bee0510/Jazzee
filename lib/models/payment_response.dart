class PaymentDetailsResponse {
  int status;
  bool error;
  PaymentDetailsMessages messages;

  PaymentDetailsResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory PaymentDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PaymentDetailsResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: PaymentDetailsMessages.fromJson(json['messages'] ?? {}),
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

class PaymentDetailsMessages {
  String responseCode;
  PaymentDetailsStatus status;

  PaymentDetailsMessages({
    required this.responseCode,
    required this.status,
  });

  factory PaymentDetailsMessages.fromJson(Map<String, dynamic> json) {
    return PaymentDetailsMessages(
      responseCode: json['responsecode'] ?? '',
      status: PaymentDetailsStatus.fromJson(json['status'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responsecode': responseCode,
      'status': status.toJson(),
    };
  }
}

class PaymentDetailsStatus {
  List<PaymentDetail> paymentDetails;

  PaymentDetailsStatus({
    required this.paymentDetails,
  });

  factory PaymentDetailsStatus.fromJson(Map<String, dynamic> json) {
    var list = json['payment_details'] as List? ?? [];
    List<PaymentDetail> paymentDetailsList =
        list.map((i) => PaymentDetail.fromJson(i)).toList();

    return PaymentDetailsStatus(
      paymentDetails: paymentDetailsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_details': paymentDetails.map((e) => e.toJson()).toList(),
    };
  }
}

class PaymentDetail {
  String trId;
  String custId;
  String orderId;
  String tAmount;
  String paidAmount;
  String paymentType;
  String paymentMode;
  String transactionId;
  String date;
  String createdDate;

  PaymentDetail({
    required this.trId,
    required this.custId,
    required this.orderId,
    required this.tAmount,
    required this.paidAmount,
    required this.paymentType,
    required this.paymentMode,
    required this.transactionId,
    required this.date,
    required this.createdDate,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      trId: json['tr_id'] ?? '',
      custId: json['cust_id'] ?? '',
      orderId: json['order_id'] ?? '',
      tAmount: json['t_amount'] ?? '',
      paidAmount: json['paid_amount'] ?? '',
      paymentType: json['payment_type'] ?? '',
      paymentMode: json['payment_mode'] ?? '',
      transactionId: json['tranction_id'] ?? '',
      date: json['date'] ?? '',
      createdDate: json['created_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tr_id': trId,
      'cust_id': custId,
      'order_id': orderId,
      't_amount': tAmount,
      'paid_amount': paidAmount,
      'payment_type': paymentType,
      'payment_mode': paymentMode,
      'tranction_id': transactionId,
      'date': date,
      'created_date': createdDate,
    };
  }
}
