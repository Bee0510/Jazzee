class User {
  final String id;
  final String aud;
  final String role;
  final String email;
  final String emailConfirmedAt;
  final String phone;
  final String lastSignInAt;
  final Map<String, dynamic> appMetadata;
  final Map<String, dynamic> userMetadata;
  final List<UserIdentity> identities;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.aud,
    required this.role,
    required this.email,
    required this.emailConfirmedAt,
    required this.phone,
    required this.lastSignInAt,
    required this.appMetadata,
    required this.userMetadata,
    required this.identities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      aud: json['aud'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      emailConfirmedAt: json['emailConfirmedAt'] ?? '',
      phone: json['phone'] ?? '',
      lastSignInAt: json['lastSignInAt'] ?? '',
      appMetadata: json['appMetadata'] ?? {},
      userMetadata: json['userMetadata'] ?? {},
      identities: (json['identities'] as List<dynamic>?)
              ?.map((identity) => UserIdentity.fromJson(identity))
              .toList() ??
          [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aud': aud,
      'role': role,
      'email': email,
      'emailConfirmedAt': emailConfirmedAt,
      'phone': phone,
      'lastSignInAt': lastSignInAt,
      'appMetadata': appMetadata,
      'userMetadata': userMetadata,
      'identities': identities.map((identity) => identity.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class UserIdentity {
  final String identityId;
  final String id;
  final String userId;
  final Map<String, dynamic> identityData;
  final String provider;
  final String lastSignInAt;
  final String createdAt;
  final String updatedAt;

  UserIdentity({
    required this.identityId,
    required this.id,
    required this.userId,
    required this.identityData,
    required this.provider,
    required this.lastSignInAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserIdentity.fromJson(Map<String, dynamic> json) {
    return UserIdentity(
      identityId: json['identityId'] ?? '',
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      identityData: json['identityData'] ?? {},
      provider: json['provider'] ?? '',
      lastSignInAt: json['lastSignInAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identityId': identityId,
      'id': id,
      'userId': userId,
      'identityData': identityData,
      'provider': provider,
      'lastSignInAt': lastSignInAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
