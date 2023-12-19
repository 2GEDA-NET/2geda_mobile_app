import 'dart:convert';

class TicketReportData {
  final String? name;
  final String? id;
  final String? ticketType;
  final String? date;
  final String? price;

  TicketReportData(this.name, this.id, this.ticketType, this.date, this.price);

  static fromJson(json) {}
}


class Event {
    int? id;
    User? user;
    dynamic url;
    String? platform;
    String? desc;
    String? location;
    dynamic image;
    String? title;
    DateTime? date;
    bool? isPopular;
    bool? isPromoted;
    String? eventKey;
    bool? isPublic;
    bool? addToSales;
    String? formatedDate;

    Event({
        required this.id,
        required this.user,
        required this.url,
        required this.platform,
        required this.desc,
        required this.location,
        required this.image,
        required this.title,
        required this.date,
        required this.isPopular,
        required this.isPromoted,
        required this.eventKey,
        required this.isPublic,
        required this.addToSales,
        required this.formatedDate,
    });

    factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        user: User.fromJson(json["user"]),
        url: json["url"],
        platform: json["platform"],
        desc: json["desc"],
        location: json["location"],
        image: json["image"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        isPopular: json["is_popular"],
        isPromoted: json["is_promoted"],
        eventKey: json["event_key"],
        isPublic: json["is_public"],
        addToSales: json["add_to_sales"],
        formatedDate: json["formated_date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "url": url,
        "platform": platform,
        "desc": desc,
        "location": location,
        "image": image,
        "title": title,
        "date": date!.toIso8601String(),
        "is_popular": isPopular,
        "is_promoted": isPromoted,
        "event_key": eventKey,
        "is_public": isPublic,
        "add_to_sales": addToSales,
        "formated_date": formatedDate,
    };
}

class User {
    int? id;
    String? email;
    bool? isBusiness;
    bool? isPersonal;
    int? accountBalance;
    bool? isAdmin;
    String? username;
    dynamic phoneNumber;
    bool? isVerified;
    Address? address;
    List<dynamic> media;
    CoverImage? coverImage;
    dynamic lastSeen;
    dynamic bio;

    User({
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

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        isBusiness: json["is_business"],
        isPersonal: json["is_personal"],
        accountBalance: json["account_balance"],
        isAdmin: json["is_admin"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        isVerified: json["is_verified"],
        address: Address.fromJson(json["address"]),
        media: List<dynamic>.from(json["media"].map((x) => x)),
        coverImage: CoverImage.fromJson(json["cover_image"]),
        lastSeen: json["last_seen"],
        bio: json["bio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_business": isBusiness,
        "is_personal": isPersonal,
        "account_balance": accountBalance,
        "is_admin": isAdmin,
        "username": username,
        "phone_number": phoneNumber,
        "is_verified": isVerified,
        "address": address!.toJson(),
        "media": List<dynamic>.from(media.map((x) => x)),
        "cover_image": coverImage!.toJson(),
        "last_seen": lastSeen,
        "bio": bio,
    };
}

class Address {
    int? id;
    String? country;
    dynamic city;
    String? currentCity;
    dynamic streetAddress;
    dynamic apartmentAddress;
    dynamic location;
    dynamic postalCode;
    DateTime createdAt;
    DateTime updatedAt;
    int? user;

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

    factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        country: json["country"],
        city: json["city"],
        currentCity: json["current_city"],
        streetAddress: json["street_address"],
        apartmentAddress: json["apartment_address"],
        location: json["location"],
        postalCode: json["postal_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "city": city,
        "current_city": currentCity,
        "street_address": streetAddress,
        "apartment_address": apartmentAddress,
        "location": location,
        "postal_code": postalCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
    };
}

class CoverImage {
    int? id;
    String? coverImage;
    int? user;

    CoverImage({
        required this.id,
        required this.coverImage,
        required this.user,
    });

    factory CoverImage.fromRawJson(String str) => CoverImage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        id: json["id"],
        coverImage: json["cover_image"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cover_image": coverImage,
        "user": user,
    };
}
