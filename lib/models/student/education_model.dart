class Education {
  final String educationId;
  final String studentId;
  final String instituteName;
  final String startYear;
  final String? endYear;
  final String degreeName;
  final String stream;
  final String marksPerCgpa;

  Education({
    required this.educationId,
    required this.studentId,
    required this.instituteName,
    required this.startYear,
    this.endYear,
    required this.degreeName,
    required this.stream,
    required this.marksPerCgpa,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      educationId: json['education_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      instituteName: json['institute_name'] ?? '',
      startYear: json['start_year'] ?? '',
      endYear: json['end_year'],
      degreeName: json['degree_name'] ?? '',
      stream: json['stream'] ?? '',
      marksPerCgpa: json['marks_per_cgpa'] ?? '',
    );
  }
}
