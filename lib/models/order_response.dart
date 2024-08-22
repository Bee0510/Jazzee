import 'dart:convert';

class OrderResponse {
  final int status;
  final bool error;
  final String message;
  final List<orderData> data;

  OrderResponse({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      data: List<orderData>.from(
          json['data']?.map((x) => orderData.fromJson(x)) ?? []),
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

class orderData {
  final String ordersId;
  final String productName;
  final String? variationId;
  final String qty;
  final String img;
  final String price;
  final String userId;
  final String? shippingType;
  final String? shippingCharge;
  final String orderId;
  final String addressId;
  final String paymentMode;
  final String status;
  final String? reason;
  final String wallet;
  final String? txnId;
  final String couponCode;
  final String couponAmnt;
  final String createdDate;
  final String updateDate;

  orderData({
    required this.ordersId,
    required this.productName,
    this.variationId,
    required this.qty,
    required this.img,
    required this.price,
    required this.userId,
    this.shippingType,
    this.shippingCharge,
    required this.orderId,
    required this.addressId,
    required this.paymentMode,
    required this.status,
    this.reason,
    required this.wallet,
    this.txnId,
    required this.couponCode,
    required this.couponAmnt,
    required this.createdDate,
    required this.updateDate,
  });

  factory orderData.fromJson(Map<String, dynamic> json) {
    return orderData(
      ordersId: json['orders_id'] ?? '',
      productName: json['productname'] ?? '',
      variationId: json['variation_id'],
      qty: json['qty'] ?? '',
      img: json['img'] ?? '',
      price: json['price'] ?? '',
      userId: json['user_id'] ?? '',
      shippingType: json['shipping_type'],
      shippingCharge: json['shipping_charge'],
      orderId: json['order_id'] ?? '',
      addressId: json['address_id'] ?? '',
      paymentMode: json['payment_mode'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'],
      wallet: json['wallet'] ?? '',
      txnId: json['txn_id'],
      couponCode: json['coupon_code'] ?? '',
      couponAmnt: json['coupon_amnt'] ?? '',
      createdDate: json['created_date'] ?? '',
      updateDate: json['update_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders_id': ordersId,
      'productname': productName,
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
