class StudentPlaced {
  final int studentId;
  final int collageId;
  final bool isPlaced;

  StudentPlaced({
    required this.studentId,
    required this.collageId,
    required this.isPlaced,
  });

  factory StudentPlaced.fromJson(Map<String, dynamic> json) {
    return StudentPlaced(
      studentId: json['student_id'] ?? 0,
      collageId: json['collage_id'] ?? 0,
      isPlaced: json['is_placed'] ?? false,
    );
  }
}
