import 'dart:convert';

class home_response {
  int status;
  bool error;
  homeData messages;

  home_response({
    required this.status,
    required this.error,
    required this.messages,
  });

  factory home_response.fromJson(Map<String, dynamic> json) {
    return home_response(
      status: json['status'] ?? 0,
      error: json['error'] ?? false,
      messages: homeData.fromJson(json['messages'] ?? {}),
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

class homeData {
  String responseCode;
  Status status;

  homeData({
    required this.responseCode,
    required this.status,
  });

  factory homeData.fromJson(Map<String, dynamic> json) {
    return homeData(
      responseCode: json['responsecode'] ?? '',
      status: Status.fromJson(json['status'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responsecode': responseCode,
      'status': status.toJson(),
    };
  }
}

class Status {
  List<Offer> offer;
  List<Brand> brands;
  List<Banners> banner;
  List<CategoryData> categoryData;

  Status({
    required this.offer,
    required this.brands,
    required this.banner,
    required this.categoryData,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      offer: (json['offer'] as List? ?? [])
          .map((i) => Offer.fromJson(i ?? {}))
          .toList(),
      brands: (json['brands'] as List? ?? [])
          .map((i) => Brand.fromJson(i ?? {}))
          .toList(),
      banner: (json['banner'] as List? ?? [])
          .map((i) => Banners.fromJson(i ?? {}))
          .toList(),
      categoryData: (json['category_data'] as List? ?? [])
          .map((i) => CategoryData.fromJson(i ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer': offer.map((e) => e.toJson()).toList(),
      'brands': brands.map((e) => e.toJson()).toList(),
      'banner': banner.map((e) => e.toJson()).toList(),
      'category_data': categoryData.map((e) => e.toJson()).toList(),
    };
  }
}

class Offer {
  String couponCodeId;
  String name;
  String img;
  String code;
  String noOfUseUser;
  String discountType;
  String discountValue;
  String validUoTo;
  String usedUpTo;
  String priceCart;
  String createDate;
  String updateDate;

  Offer({
    required this.couponCodeId,
    required this.name,
    required this.img,
    required this.code,
    required this.noOfUseUser,
    required this.discountType,
    required this.discountValue,
    required this.validUoTo,
    required this.usedUpTo,
    required this.priceCart,
    required this.createDate,
    required this.updateDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      couponCodeId: json['coupon_code_id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      code: json['code'] ?? '',
      noOfUseUser: json['no_of_use_user'] ?? '',
      discountType: json['discount_type'] ?? '',
      discountValue: json['discount_value'] ?? '',
      validUoTo: json['valid_uo_to'] ?? '',
      usedUpTo: json['used_up_to'] ?? '',
      priceCart: json['price_cart'] ?? '',
      createDate: json['create_date'] ?? '',
      updateDate: json['update_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coupon_code_id': couponCodeId,
      'name': name,
      'img': img,
      'code': code,
      'no_of_use_user': noOfUseUser,
      'discount_type': discountType,
      'discount_value': discountValue,
      'valid_uo_to': validUoTo,
      'used_up_to': usedUpTo,
      'price_cart': priceCart,
      'create_date': createDate,
      'update_date': updateDate,
    };
  }
}

class Brand {
  String brandsId;
  String brandsName;
  String images;
  String status;
  dynamic displayInHome;
  String createdDate;
  String updatedDate;

  Brand({
    required this.brandsId,
    required this.brandsName,
    required this.images,
    required this.status,
    required this.displayInHome,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandsId: json['brands_id'] ?? '',
      brandsName: json['brands_name'] ?? '',
      images: json['images'] ?? '',
      status: json['status'] ?? '',
      displayInHome: json['display_in_home'],
      createdDate: json['created_date'] ?? '',
      updatedDate: json['updated_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brands_id': brandsId,
      'brands_name': brandsName,
      'images': images,
      'status': status,
      'display_in_home': displayInHome,
      'created_date': createdDate,
      'updated_date': updatedDate,
    };
  }
}

class Banners {
  String bannerId;
  String bannerTitle;
  String bannerSubtitle;
  String description;
  String urrl;
  String type;
  String orderby;
  String image;
  String createdDate;
  String updatedDate;

  Banners({
    required this.bannerId,
    required this.bannerTitle,
    required this.bannerSubtitle,
    required this.description,
    required this.urrl,
    required this.type,
    required this.orderby,
    required this.image,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      bannerId: json['banner_id'] ?? '',
      bannerTitle: json['banner_title'] ?? '',
      bannerSubtitle: json['banner_subtitle'] ?? '',
      description: json['description'] ?? '',
      urrl: json['urrl'] ?? '',
      type: json['type'] ?? '',
      orderby: json['orderby'] ?? '',
      image: json['image'] ?? '',
      createdDate: json['created_date'] ?? '',
      updatedDate: json['updated_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_id': bannerId,
      'banner_title': bannerTitle,
      'banner_subtitle': bannerSubtitle,
      'description': description,
      'urrl': urrl,
      'type': type,
      'orderby': orderby,
      'image': image,
      'created_date': createdDate,
      'updated_date': updatedDate,
    };
  }
}

class CategoryData {
  String catId;
  String catName;
  String parentId;
  String catImg;
  String type;
  String status;
  String createdDate;
  List<Subcategory_catagory> subcategories;

  CategoryData({
    required this.catId,
    required this.catName,
    required this.parentId,
    required this.catImg,
    required this.type,
    required this.status,
    required this.createdDate,
    required this.subcategories,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      catId: json['cat_id'] ?? '',
      catName: json['cat_name'] ?? '',
      parentId: json['parent_id'] ?? '',
      catImg: json['cat_img'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      createdDate: json['created_date'] ?? '',
      subcategories: (json['subcategories'] as List? ?? [])
          .map((i) => Subcategory_catagory.fromJson(i ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'cat_name': catName,
      'parent_id': parentId,
      'cat_img': catImg,
      'type': type,
      'status': status,
      'created_date': createdDate,
      'subcategories': subcategories.map((e) => e.toJson()).toList(),
    };
  }
}

class Subcategory_catagory {
  String catId;
  String catName;
  String parentId;
  String catImg;
  String type;
  String status;
  String createdDate;
  List<dynamic> subcategories;

  Subcategory_catagory({
    required this.catId,
    required this.catName,
    required this.parentId,
    required this.catImg,
    required this.type,
    required this.status,
    required this.createdDate,
    required this.subcategories,
  });

  factory Subcategory_catagory.fromJson(Map<String, dynamic> json) {
    return Subcategory_catagory(
      catId: json['cat_id'] ?? '',
      catName: json['cat_name'] ?? '',
      parentId: json['parent_id'] ?? '',
      catImg: json['cat_img'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      createdDate: json['created_date'] ?? '',
      subcategories: json['subcategories'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'cat_name': catName,
      'parent_id': parentId,
      'cat_img': catImg,
      'type': type,
      'status': status,
      'created_date': createdDate,
      'subcategories': subcategories,
    };
  }
}
