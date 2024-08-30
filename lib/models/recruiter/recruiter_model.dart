import '../college/college_model.dart';

class Recruiter {
  final String companyId;
  final String companyName;
  final String? companyTelephone;
  final String? companyEmail;
  final int? locations;
  final String? image;
  final bool verified;
  final Collage? collageColl;
  final String roleType;
  final String gst;
  final String link;
  final String token;

  Recruiter(
      {required this.companyId,
      required this.companyName,
      this.companyTelephone,
      this.companyEmail,
      this.locations,
      this.image,
      this.verified = false,
      this.collageColl,
      required this.roleType,
      required this.gst,
      required this.link,
      required this.token});

  factory Recruiter.fromJson(Map<String, dynamic> json, Collage? collage) {
    return Recruiter(
        companyId: json['company_id'] ?? '',
        companyName: json['company_name'] ?? '',
        companyTelephone: json['company_telephone'],
        companyEmail: json['company_email'],
        locations: json['locations'],
        image: json['image'],
        verified: json['verified'] ?? false,
        collageColl: collage,
        roleType: json['role_type'] ?? '',
        gst: json['gst'] ?? '',
        link: json['link'] ?? '',
        token: json['token'] ?? '');
  }
}
