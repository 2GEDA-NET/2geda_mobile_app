class Post {
  Post({
    required this.id,
    required this.user,
    required this.commentText,
    required this.eachMedia,
    required this.hashtags,
    required this.content,
    required this.reaction,
    required this.postReactionCount,
    required this.postCommentCount,
    required this.media,
    required this.timeStamp,
    required this.shares,
    required this.comment,
    required this.likes,
    required this.love,
    required this.dislike,
    required this.otherReactions,
    required this.isPaid,
    required this.postType,
    required this.isBusinessPost,
    required this.isPersonalPost,
    required this.timeSince,
    required this.userProfile,
    required this.post,
    required this.taggedUsersPost,
  });

  final int? id;
  final User? user;
  final List<CommentText> commentText;
  final List<EachMedia> eachMedia;
  final List<Hashtag> hashtags;
  final String? content;
  final List<Reaction> reaction;
  final int? postReactionCount;
  final int? postCommentCount;
  final String? media;
  final DateTime? timeStamp;
  final int? shares;
  final int? comment;
  final int? likes;
  final int? love;
  final int? dislike;
  final int? otherReactions;
  final bool? isPaid;
  final String? postType;
  final bool? isBusinessPost;
  final bool? isPersonalPost;
  final String? timeSince;
  final dynamic userProfile;
  final int? post;
  final List<int> taggedUsersPost;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      commentText: json["comment_text"] == null
          ? []
          : List<CommentText>.from(
              json["comment_text"]!.map((x) => CommentText.fromJson(x))),
      eachMedia: json["each_media"] == null
          ? []
          : List<EachMedia>.from(
              json["each_media"]!.map((x) => EachMedia.fromJson(x))),
      hashtags: json["hashtags"] == null
          ? []
          : List<Hashtag>.from(
              json["hashtags"]!.map((x) => Hashtag.fromJson(x))),
      content: json["content"],
      reaction: json["Reaction"] == null
          ? []
          : List<Reaction>.from(
              json["Reaction"]!.map((x) => Reaction.fromJson(x))),
      postReactionCount: json["post_reaction_count"],
      postCommentCount: json["post_comment_count"],
      media: json["media"],
      timeStamp: DateTime.tryParse(json["time_stamp"] ?? ""),
      shares: json["shares"],
      comment: json["comment"],
      likes: json["likes"],
      love: json["love"],
      dislike: json["dislike"],
      otherReactions: json["other_reactions"],
      isPaid: json["is_paid"],
      postType: json["post_type"],
      isBusinessPost: json["is_business_post"],
      isPersonalPost: json["is_personal_post"],
      timeSince: json["time_since"],
      userProfile: json["user_profile"],
      post: json["post"],
      taggedUsersPost: json["tagged_users_post"] == null
          ? []
          : List<int>.from(json["tagged_users_post"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "comment_text": commentText.map((x) => x.toJson()).toList(),
        "each_media": eachMedia.map((x) => x.toJson()).toList(),
        "hashtags": hashtags.map((x) => x.toJson()).toList(),
        "content": content,
        "Reaction": reaction.map((x) => x.toJson()).toList(),
        "post_reaction_count": postReactionCount,
        "post_comment_count": postCommentCount,
        "media": media,
        "time_stamp": timeStamp?.toIso8601String(),
        "shares": shares,
        "comment": comment,
        "likes": likes,
        "love": love,
        "dislike": dislike,
        "other_reactions": otherReactions,
        "is_paid": isPaid,
        "post_type": postType,
        "is_business_post": isBusinessPost,
        "is_personal_post": isPersonalPost,
        "time_since": timeSince,
        "user_profile": userProfile,
        "post": post,
        "tagged_users_post": taggedUsersPost.map((x) => x).toList(),
      };
}

class CommentText {
  CommentText({
    required this.id,
    required this.user,
    required this.reaction,
    required this.responses,
    required this.media,
    required this.reactionCount,
    required this.responsesCount,
    required this.content,
    required this.timestamp,
    required this.timeStamp,
    required this.post,
    required this.parent,
    required this.timeSince,
  });

  final int? id;
  final User? user;
  final List<dynamic> reaction;
  final List<dynamic> responses;
  final List<dynamic> media;
  final int? reactionCount;
  final int? responsesCount;
  final String? content;
  final String? timestamp;
  final DateTime? timeStamp;
  final int? post;
  final dynamic parent;
  final String? timeSince;

  factory CommentText.fromJson(Map<String, dynamic> json) {
    return CommentText(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      reaction: json["reaction"] == null
          ? []
          : List<dynamic>.from(json["reaction"]!.map((x) => x)),
      responses: json["responses"] == null
          ? []
          : List<dynamic>.from(json["responses"]!.map((x) => x)),
      media: json["media"] == null
          ? []
          : List<dynamic>.from(json["media"]!.map((x) => x)),
      reactionCount: json["reaction_count"],
      responsesCount: json["responses_count"],
      content: json["content"],
      timestamp: json["timestamp"],
      timeStamp: DateTime.tryParse(json["time_stamp"] ?? ""),
      post: json["post"],
      parent: json["parent"],
      timeSince: json["time_since"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "reaction": reaction.map((x) => x).toList(),
        "responses": responses.map((x) => x).toList(),
        "media": media.map((x) => x).toList(),
        "reaction_count": reactionCount,
        "responses_count": responsesCount,
        "content": content,
        "timestamp": timestamp,
        "time_stamp": timeStamp?.toIso8601String(),
        "post": post,
        "parent": parent,
        "time_since": timeSince,
      };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.isBusiness,
    required this.isPersonal,
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
  final bool? isAdmin;
  final String? username;
  final int? phoneNumber;
  final bool? isVerified;
  final Address? address;
  final List<dynamic> media;
  final CoverImage? coverImage;
  final dynamic lastSeen;
  final dynamic bio;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      isBusiness: json["is_business"],
      isPersonal: json["is_personal"],
      isAdmin: json["is_admin"],
      username: json["username"],
      phoneNumber: json["phone_number"],
      isVerified: json["is_verified"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      media: json["media"] == null
          ? []
          : List<dynamic>.from(json["media"]!.map((x) => x)),
      coverImage: json["cover_image"] == null
          ? null
          : CoverImage.fromJson(json["cover_image"]),
      lastSeen: json["last_seen"],
      bio: json["bio"],
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
        "address": address?.toJson(),
        "media": media.map((x) => x).toList(),
        "cover_image": coverImage?.toJson(),
        "last_seen": lastSeen,
        "bio": bio,
      };
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "city": city,
        "current_city": currentCity,
        "street_address": streetAddress,
        "apartment_address": apartmentAddress,
        "location": location,
        "postal_code": postalCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
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

class EachMedia {
  EachMedia({
    required this.user,
    required this.media,
  });

  final int? user;
  final String? media;

  factory EachMedia.fromJson(Map<String, dynamic> json) {
    return EachMedia(
      user: json["user"],
      media: json["media"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user,
        "media": media,
      };
}

class Hashtag {
  Hashtag({
    required this.id,
    required this.user,
    required this.hashTags,
    required this.post,
  });

  final int? id;
  final String? user;
  final String? hashTags;
  final dynamic post;

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      id: json["id"],
      user: json["user"],
      hashTags: json["hash_tags"],
      post: json["post"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "hash_tags": hashTags,
        "post": post,
      };
}

class Reaction {
  Reaction({
    required this.id,
    required this.user,
    required this.reactionType,
  });

  final int? id;
  final User? user;
  final String? reactionType;

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      reactionType: json["reaction_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "reaction_type": reactionType,
      };
}
