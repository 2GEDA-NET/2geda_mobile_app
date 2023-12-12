class GetConnectModel {
  GetConnectModel({
    required this.id,
    required this.email,
    required this.isBusiness,
    required this.isPersonal,
    required this.isAdmin,
    required this.username,
    required this.phoneNumber,
    required this.isVerified,
    required this.media,
    required this.coverImage,
    required this.lastSeen,
  });

  final int? id;
  final String? email;
  final bool? isBusiness;
  final bool? isPersonal;
  final bool? isAdmin;
  final String? username;
  final int? phoneNumber;
  final bool? isVerified;
  final List<Media> media;
  final CoverImage? coverImage;
  final dynamic lastSeen;

  factory GetConnectModel.fromJson(Map<String, dynamic> json) {
    return GetConnectModel(
      id: json["id"],
      email: json["email"],
      isBusiness: json["is_business"],
      isPersonal: json["is_personal"],
      isAdmin: json["is_admin"],
      username: json["username"],
      phoneNumber: json["phone_number"],
      isVerified: json["is_verified"],
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      coverImage: json["cover_image"] == null
          ? null
          : CoverImage.fromJson(json["cover_image"]),
      lastSeen: json["last_seen"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_business": isBusiness,
        "is_personal": isPersonal,
        "is_admin": isAdmin,
        "username": username,
        "phone_number": phoneNumber,
        "is_verified": isVerified,
        "media": media.map((x) => x.toJson()).toList(),
        "cover_image": coverImage?.toJson(),
        "last_seen": lastSeen,
      };
}

class CoverImage {
  CoverImage({
    required this.id,
    required this.coverImage,
    required this.user,
  });

  final int? id;
  final String? coverImage;
  final int? user;

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
      id: json["id"],
      coverImage: json["cover_image"],
      user: json["user"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover_image": coverImage,
        "user": user,
      };
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_image": profileImage,
        "user": user,
      };
}
