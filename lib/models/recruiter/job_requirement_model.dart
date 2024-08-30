class JobRequirement {
  final int requirementId;
  final int jobId;
  final String skillsRequired;
  final String? requirements;

  JobRequirement({
    required this.requirementId,
    required this.jobId,
    required this.skillsRequired,
    this.requirements,
  });

  factory JobRequirement.fromJson(Map<String, dynamic> json) {
    return JobRequirement(
      requirementId: json['requirement_id'] ?? 0,
      jobId: json['job_id'] ?? 0,
      skillsRequired: json['skills_required'] ?? '',
      requirements: json['requirements'],
    );
  }
}
