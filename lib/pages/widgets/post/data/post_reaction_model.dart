class PostReactionModel {
  PostReactionModel({
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
  final List<dynamic> eachMedia;
  final List<Hashtag> hashtags;
  final String? content;
  final List<Reaction> reaction;
  final int? postReactionCount;
  final int? postCommentCount;
  final dynamic media;
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
  final dynamic post;
  final List<dynamic> taggedUsersPost;

  factory PostReactionModel.fromJson(Map<String, dynamic> json) {
    return PostReactionModel(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      commentText: json["comment_text"] == null
          ? []
          : List<CommentText>.from(
              json["comment_text"]!.map((x) => CommentText.fromJson(x))),
      eachMedia: json["each_media"] == null
          ? []
          : List<dynamic>.from(json["each_media"]!.map((x) => x)),
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
          : List<dynamic>.from(json["tagged_users_post"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "comment_text": commentText.map((x) => x.toJson()).toList(),
        "each_media": eachMedia.map((x) => x).toList(),
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
    required this.post,
    required this.parent,
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
  final int? post;
  final dynamic parent;

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
      post: json["post"],
      parent: json["parent"],
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
        "post": post,
        "parent": parent,
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
    required this.lastSeen,
  });

  final int? id;
  final String? email;
  final bool? isBusiness;
  final bool? isPersonal;
  final bool? isAdmin;
  final String? username;
  final dynamic phoneNumber;
  final bool? isVerified;
  final dynamic lastSeen;

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
        "last_seen": lastSeen,
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
