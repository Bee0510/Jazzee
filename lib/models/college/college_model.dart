import 'college_location_model.dart';

class Collage {
  final String collageId;
  final String collageMail;
  final String collageName;
  final String collageNo;
  final String collageCode;
  final int studentEnrolled;
  final String coordinatorName;
  final String roleType;
  final String websiteLink;
  final String token;

  Collage(
      {required this.collageId,
      required this.collageMail,
      required this.collageName,
      required this.collageNo,
      required this.collageCode,
      required this.studentEnrolled,
      required this.coordinatorName,
      required this.roleType,
      required this.websiteLink,
      required this.token});

  factory Collage.fromJson(
      Map<String, dynamic> json, CollageLocation? location) {
    return Collage(
        collageId: json['collage_id'] ?? '',
        collageMail: json['collage_mail'] ?? '',
        collageNo: json['collage_no'] ?? '',
        collageName: json['collage_name'] ?? '',
        collageCode: json['collage_code'] ?? '',
        studentEnrolled: json['student_enrolled'] ?? 0,
        coordinatorName: json['coordinator_name'] ?? '',
        roleType: json['role_type'] ?? '',
        websiteLink: json['website_link'] ?? '',
        token: json['token'] ?? '');
  }
}
