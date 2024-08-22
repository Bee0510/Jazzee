class allOrdersResponse {
  final int status;
  final bool error;
  final String message;
  final List<allorderData> data;

  allOrdersResponse({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory allOrdersResponse.fromJson(Map<String, dynamic> json) {
    return allOrdersResponse(
      status: json['status'],
      error: json['error'],
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<allorderData>.from(
              json['data'].map((x) => allorderData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': error,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class allorderData {
  final String ordersId;
  final String productname;
  final String variationId;
  final String qty;
  final String img;
  final String price;
  final String userId;
  final String shippingType;
  final String shippingCharge;
  final String orderId;
  final String addressId;
  final String paymentMode;
  final String status;
  final String reason;
  final String wallet;
  final String txnId;
  final String couponCode;
  final String couponAmnt;
  final String createdDate;
  final String updateDate;

  allorderData({
    required this.ordersId,
    required this.productname,
    required this.variationId,
    required this.qty,
    required this.img,
    required this.price,
    required this.userId,
    required this.shippingType,
    required this.shippingCharge,
    required this.orderId,
    required this.addressId,
    required this.paymentMode,
    required this.status,
    required this.reason,
    required this.wallet,
    required this.txnId,
    required this.couponCode,
    required this.couponAmnt,
    required this.createdDate,
    required this.updateDate,
  });

  factory allorderData.fromJson(Map<String, dynamic> json) {
    return allorderData(
      ordersId: json['orders_id'] ?? '',
      productname: json['productname'] ?? '',
      variationId: json['variation_id'] ?? '',
      qty: json['qty'] ?? '',
      img: json['img'] ?? '',
      price: json['price'] ?? '',
      userId: json['user_id'] ?? '',
      shippingType: json['shipping_type'] ?? '',
      shippingCharge: json['shipping_charge'] ?? '',
      orderId: json['order_id'] ?? '',
      addressId: json['address_id'] ?? '',
      paymentMode: json['payment_mode'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      wallet: json['wallet'] ?? '',
      txnId: json['txn_id'] ?? '',
      couponCode: json['coupon_code'] ?? '',
      couponAmnt: json['coupon_amnt'] ?? '',
      createdDate: json['created_date'] ?? '',
      updateDate: json['update_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders_id': ordersId,
      'productname': productname,
      'variation_id': variationId,
      'qty': qty,
      'img': img,
      'price': price,
      'user_id': userId,
      'shipping_type': shippingType,
      'shipping_charge': shippingCharge,
      'order_id': orderId,
      'address_id': addressId,
      'payment_mode': paymentMode,
      'status': status,
      'reason': reason,
      'wallet': wallet,
      'txn_id': txnId,
      'coupon_code': couponCode,
      'coupon_amnt': couponAmnt,
      'created_date': createdDate,
      'update_date': updateDate,
    };
  }
}
