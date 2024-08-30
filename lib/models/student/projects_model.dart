class Projects {
  final String projectId;
  final String projectTitle;
  final String studentId;
  final String current_status;
  final String link;
  final String startDate;
  final String? endDate;
  final String? projectDescription;

  Projects({
    required this.projectId,
    required this.projectTitle,
    required this.studentId,
    required this.current_status,
    required this.link,
    required this.startDate,
    this.endDate,
    this.projectDescription,
  });

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
      projectId: json['project_id'] ?? '',
      projectTitle: json['project_title'] ?? '',
      studentId: json['student_id'] ?? '',
      current_status: json['current_status'] ?? '',
      link: json['link'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'],
      projectDescription: json['project_description'],
    );
  }
}
