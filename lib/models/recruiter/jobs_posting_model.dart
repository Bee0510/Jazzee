class JobPosting {
  final String jobId;
  final String jobRole;
  final String companyId;
  final String? jobType;
  final String? salary;
  final String? applyTill;
  final bool verified;
  final bool recruteStatus;
  final String totalRecruited;
  final String isSpecific;
  final String? jobDescription;
  final String totalOpening;
  final String jobSkills;
  final String jobLocation;
  final String companyName;
  final bool acceptedByCollage;

  JobPosting(
      {required this.jobId,
      required this.jobRole,
      required this.companyId,
      this.jobType,
      required this.salary,
      this.applyTill,
      this.verified = false,
      this.recruteStatus = false,
      required this.jobSkills,
      this.totalRecruited = '0',
      required this.isSpecific,
      required this.acceptedByCollage,
      this.jobDescription,
      required this.totalOpening,
      required this.jobLocation,
      required this.companyName});

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      jobId: json['job_id'] ?? '',
      jobRole: json['job_role'] ?? '',
      companyId: json['company_id'] ?? '',
      jobType: json['job_type'],
      salary: json['salary'] ?? '',
      jobSkills: json['job_requirement'] ?? '',
      applyTill: json['apply_till'] ?? '',
      verified: json['verified'] ?? false,
      recruteStatus: json['recrute_status'] ?? false,
      totalRecruited: json['total_recruited'] ?? '0',
      isSpecific: json['is_specific'] ?? '',
      acceptedByCollage: json['accepted_by_collage'] ?? false,
      jobDescription: json['job_description'],
      totalOpening: json['total_opening'] ?? '0',
      jobLocation: json['job_location'] ?? '',
      companyName: json['company_name'] ?? '',
    );
  }
}
