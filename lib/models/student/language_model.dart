class Language {
  final int languageId;
  final int studentId;
  final String languageName;

  Language({
    required this.languageId,
    required this.studentId,
    required this.languageName,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageId: json['language_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      languageName: json['language_name'] ?? '',
    );
  }
}
