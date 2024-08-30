class Link {
  final int linkId;
  final int studentId;
  final String linkName;
  final String linkUrl;

  Link({
    required this.linkId,
    required this.studentId,
    required this.linkName,
    required this.linkUrl,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      linkId: json['link_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      linkName: json['link_name'] ?? '',
      linkUrl: json['link_url'] ?? '',
    );
  }
}
