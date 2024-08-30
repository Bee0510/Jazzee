class CollageLocation {
  final int collageLocationId;
  final String address1;
  final String? address2;
  final String city;
  final String town;
  final String pincode;
  final String state;
  final String country;

  CollageLocation({
    required this.collageLocationId,
    required this.address1,
    this.address2,
    required this.city,
    required this.town,
    required this.pincode,
    required this.state,
    required this.country,
  });

  factory CollageLocation.fromJson(Map<String, dynamic> json) {
    return CollageLocation(
      collageLocationId: json['collage_location_id'] ?? 0,
      address1: json['address1'] ?? '',
      address2: json['address2'],
      city: json['city'] ?? '',
      town: json['town'] ?? '',
      pincode: json['pincode'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
