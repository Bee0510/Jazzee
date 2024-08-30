class WorkExperience {
  final String workExpId;
  final String studentId;
  final String designation;
  final String organization;
  final String jobLocation;
  final String startDate;
  final String? endDate;
  final String? workDescription;

  WorkExperience({
    required this.workExpId,
    required this.studentId,
    required this.designation,
    required this.organization,
    required this.jobLocation,
    required this.startDate,
    this.endDate,
    this.workDescription,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      workExpId: json['work_exp_id'] ?? '',
      studentId: json['student_id'] ?? '',
      designation: json['designation'] ?? '',
      organization: json['organization'] ?? '',
      jobLocation: json['job_location'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'],
      workDescription: json['work_description'],
    );
  }
}
