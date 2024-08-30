class CollageContact {
  final int collageContactId;
  final int collageId;
  final String email;
  final String telephone;

  CollageContact({
    required this.collageContactId,
    required this.collageId,
    required this.email,
    required this.telephone,
  });

  factory CollageContact.fromJson(Map<String, dynamic> json) {
    return CollageContact(
      collageContactId: json['collage_contact_id'] ?? 0,
      collageId: json['collage_id'] ?? 0,
      email: json['email'] ?? '',
      telephone: json['telephone'] ?? '',
    );
  }
}
