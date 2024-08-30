class Skill {
  final String skillId;
  final String studentId;
  final String skillName;
  final String skillLevel;

  Skill({
    required this.skillId,
    required this.studentId,
    required this.skillName,
    required this.skillLevel,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      skillId: json['skill_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      skillName: json['skill_name'] ?? '',
      skillLevel: json['skill_level'] ?? '',
    );
  }
}
