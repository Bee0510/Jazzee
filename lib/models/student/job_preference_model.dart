class JobPreference {
  final int preferenceId;
  final int studentId;
  final String jobTitle;
  final String jobTypes;
  final String workSchedule;
  final int baseSalary;

  JobPreference({
    required this.preferenceId,
    required this.studentId,
    required this.jobTitle,
    required this.jobTypes,
    required this.workSchedule,
    required this.baseSalary,
  });

  factory JobPreference.fromJson(Map<String, dynamic> json) {
    return JobPreference(
      preferenceId: json['preference_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      jobTitle: json['job_title'] ?? '',
      jobTypes: json['job_types'] ?? '',
      workSchedule: json['work_schedule'] ?? '',
      baseSalary: json['base_salary'] ?? 0,
    );
  }
}
