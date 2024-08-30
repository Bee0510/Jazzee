class Locations {
  final String locationId;
  final String userId;
  final String address1;
  final String? address2;
  final String pinCode;
  final String city;
  final String state;
  final String country;

  Locations({
    required this.locationId,
    required this.userId,
    required this.address1,
    this.address2,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.country,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      locationId: json['location_id'] ?? '',
      userId: json['user_id'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'],
      pinCode: json['pin_code'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
