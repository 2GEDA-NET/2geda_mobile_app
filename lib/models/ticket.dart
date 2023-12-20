
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

    final int? id;
    final User? user;
    final dynamic url;
    final String? platform;
    final String? desc;
    final String? location;
    final dynamic image;
    final String? title;
    final DateTime? date;
    final bool? isPopular;
    final bool? isPromoted;
    final String? eventKey;
    final bool? isPublic;
    final bool? addToSales;
    final String? formatedDate;

    factory Event.fromJson(Map<String, dynamic> json){ 
        return Event(
            id: json["id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            url: json["url"],
            platform: json["platform"],
            desc: json["desc"],
            location: json["location"],
            image: json["image"],
            title: json["title"],
            date: DateTime.tryParse(json["date"] ?? ""),
            isPopular: json["is_popular"],
            isPromoted: json["is_promoted"],
            eventKey: json["event_key"],
            isPublic: json["is_public"],
            addToSales: json["add_to_sales"],
            formatedDate: json["formated_date"],
        );
    }

}

class User {
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

    final int? id;
    final String? email;
    final bool? isBusiness;
    final bool? isPersonal;
    final int? accountBalance;
    final bool? isAdmin;
    final String? username;
    final dynamic phoneNumber;
    final bool? isVerified;
    final Address? address;
    final List<dynamic> media;
    final CoverImage? coverImage;
    final dynamic lastSeen;
    final dynamic bio;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            email: json["email"],
            isBusiness: json["is_business"],
            isPersonal: json["is_personal"],
            accountBalance: json["account_balance"],
            isAdmin: json["is_admin"],
            username: json["username"],
            phoneNumber: json["phone_number"],
            isVerified: json["is_verified"],
            address: json["address"] == null ? null : Address.fromJson(json["address"]),
            media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
            coverImage: json["cover_image"] == null ? null : CoverImage.fromJson(json["cover_image"]),
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

    factory Address.fromJson(Map<String, dynamic> json){ 
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

class CoverImage {
    CoverImage({
        required this.id,
        required this.coverImage,
        required this.user,
    });

    final int? id;
    final String? coverImage;
    final int? user;

    factory CoverImage.fromJson(Map<String, dynamic> json){ 
        return CoverImage(
            id: json["id"],
            coverImage: json["cover_image"],
            user: json["user"],
        );
    }

}
