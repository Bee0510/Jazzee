class catagoryResponse {
  int status;
  bool error;
  CatMessage messages;

  catagoryResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory catagoryResponse.fromJson(Map<String, dynamic> json) {
    return catagoryResponse(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: CatMessage.fromJson(json['messages'] ?? {}),
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

class CatMessage {
  String responseCode;
  CatStatus status;

  CatMessage({
    required this.responseCode,
    required this.status,
  });

  factory CatMessage.fromJson(Map<String, dynamic> json) {
    return CatMessage(
      responseCode: json['responsecode'] ?? '',
      status: CatStatus.fromJson(json['status'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responsecode': responseCode,
      'status': status.toJson(),
    };
  }
}

class CatStatus {
  List<ProductData> productData;

  CatStatus({
    required this.productData,
  });

  factory CatStatus.fromJson(Map<String, dynamic> json) {
    return CatStatus(
      productData: (json['product_data'] as List<dynamic>?)
              ?.map((data) => ProductData.fromJson(data))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_data': productData.map((data) => data.toJson()).toList(),
    };
  }
}

class ProductData {
  String productId;
  String productName;
  String primaryImage;
  String productType;
  String regularPrice;
  String salesPrice;
  String? brandsId;
  String? brandsName;
  String description;
  String status;
  List<Attribute> attributes;

  ProductData({
    required this.productId,
    required this.productName,
    required this.primaryImage,
    required this.productType,
    required this.regularPrice,
    required this.salesPrice,
    this.brandsId,
    this.brandsName,
    required this.description,
    required this.status,
    required this.attributes,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      primaryImage: json['primary_image'] ?? '',
      productType: json['product_type'] ?? '',
      regularPrice: json['regular_price'] ?? '',
      salesPrice: json['sales_price'] ?? '',
      brandsId: json['brands_id'],
      brandsName: json['brands_name'],
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((data) => Attribute.fromJson(data))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'primary_image': primaryImage,
      'product_type': productType,
      'regular_price': regularPrice,
      'sales_price': salesPrice,
      'brands_id': brandsId,
      'brands_name': brandsName,
      'description': description,
      'status': status,
      'attributes': attributes.map((data) => data.toJson()).toList(),
    };
  }
}

class Attribute {
  String attributeId;
  String productId;
  String attributeName;
  List<Variation> variations;

  Attribute({
    required this.attributeId,
    required this.productId,
    required this.attributeName,
    required this.variations,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      attributeId: json['attribute_id'] ?? '',
      productId: json['product_id'] ?? '',
      attributeName: json['attribute_name'] ?? '',
      variations: (json['variations'] as List<dynamic>?)
              ?.map((data) => Variation.fromJson(data))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribute_id': attributeId,
      'product_id': productId,
      'attribute_name': attributeName,
      'variations': variations.map((data) => data.toJson()).toList(),
    };
  }
}

class Variation {
  String attributeId;
  String variationId;
  String variationName;

  Variation({
    required this.attributeId,
    required this.variationId,
    required this.variationName,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      attributeId: json['attribute_id'] ?? '',
      variationId: json['variation_id'] ?? '',
      variationName: json['variation_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribute_id': attributeId,
      'variation_id': variationId,
      'variation_name': variationName,
    };
  }
}
