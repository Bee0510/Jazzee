import '../college/college_model.dart';

class Student {
  final String studentId;
  final String name;
  final String phoneNo;
  final String email;
  final String? collegeId;
  final String? collageName;
  final String? image;
  final bool verified;
  final String? dateOfBirth;
  final Collage? collage;
  final String roleType;
  final bool placedOnCampus;
  final String roll_no;
  final String? resumeLink;
  final String token;

  Student({
    required this.studentId,
    required this.name,
    required this.phoneNo,
    required this.email,
    this.collegeId,
    this.collageName,
    this.image,
    this.verified = false,
    this.dateOfBirth,
    this.collage,
    required this.roleType,
    required this.placedOnCampus,
    required this.roll_no,
    this.resumeLink,
    required this.token,
  });

  factory Student.fromJson(Map<String, dynamic> json, Collage? collage) {
    return Student(
      studentId: json['student_id'] ?? '',
      name: json['name'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      email: json['email'] ?? '',
      collegeId: json['college_id'] ?? '',
      image: json['image'],
      verified: json['verified'] ?? false,
      dateOfBirth: json['date_of_birth'],
      collage: collage,
      collageName: json['collage_name'] ?? '',
      roleType: json['role_type'],
      placedOnCampus: json['placed_oncampus'] ?? false,
      resumeLink: json['resume_url'] ?? '',
      roll_no: json['roll_no'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
