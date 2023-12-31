class UserProfileModel {
  UserProfileModel({
    required this.id,
    required this.email,
    required this.isBusiness,
    required this.isPersonal,
    required this.accountBalance,
    required this.isAdmin,
    required this.username,
    required this.phoneNumber,
    required this.isVerified,
    required this.address,
    required this.media,
    required this.coverImage,
    required this.lastSeen,
    required this.bio,
  });

  final int? id;
  final dynamic email;
  final bool? isBusiness;
  final bool? isPersonal;
  final int? accountBalance;
  final bool? isAdmin;
  final String? username;
  final int? phoneNumber;
  final bool? isVerified;
  final Address? address;
  final List<Media> media;
  final dynamic coverImage;
  final dynamic lastSeen;
  final dynamic bio;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json["id"],
      email: json["email"],
      isBusiness: json["is_business"],
      isPersonal: json["is_personal"],
      accountBalance: json["account_balance"],
      isAdmin: json["is_admin"],
      username: json["username"],
      phoneNumber: json["phone_number"],
      isVerified: json["is_verified"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      coverImage: json["cover_image"],
      lastSeen: json["last_seen"],
      bio: json["bio"],
    );
  }
}

class Address {
  Address({
    required this.id,
    required this.country,
    required this.city,
    required this.currentCity,
    required this.streetAddress,
    required this.apartmentAddress,
    required this.location,
    required this.postalCode,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final int? id;
  final String? country;
  final dynamic city;
  final String? currentCity;
  final dynamic streetAddress;
  final dynamic apartmentAddress;
  final dynamic location;
  final dynamic postalCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? user;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      country: json["country"],
      city: json["city"],
      currentCity: json["current_city"],
      streetAddress: json["street_address"],
      apartmentAddress: json["apartment_address"],
      location: json["location"],
      postalCode: json["postal_code"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"],
    );
  }
}

class Media {
  Media({
    required this.id,
    required this.profileImage,
    required this.user,
  });

  final int? id;
  final String? profileImage;
  final int? user;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      profileImage: json["profile_image"],
      user: json["user"],
    );
  }
}
