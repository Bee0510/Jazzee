class Certificate {
  final int certificateId;
  final int studentId;
  final String designation;
  final String organization;
  final String receivedDate;
  final String? workDescription;

  Certificate({
    required this.certificateId,
    required this.studentId,
    required this.designation,
    required this.organization,
    required this.receivedDate,
    this.workDescription,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      certificateId: json['certificate_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      designation: json['designation'] ?? '',
      organization: json['organization'] ?? '',
      receivedDate: json['received_date'] ?? '',
      workDescription: json['work_description'],
    );
  }
}
