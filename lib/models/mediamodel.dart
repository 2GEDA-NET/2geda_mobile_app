class MediaModel {
  MediaModel({
    required this.id,
    required this.commentText,
    required this.eachMedia,
    required this.hashtags,
    required this.content,
    required this.media,
    required this.timeStamp,
    required this.shares,
    required this.comment,
    required this.likes,
    required this.love,
    required this.dislike,
    required this.otherReactions,
    required this.isBusinessPost,
    required this.isPersonalPost,
    required this.timeSince,
    required this.userProfile,
    required this.post,
    required this.taggedUsersPost,
  });

  final int? id;
  final List<dynamic> commentText;
  final List<EachMedia> eachMedia;
  final List<Hashtag> hashtags;
  final String? content;
  final String? media;
  final DateTime? timeStamp;
  final int? shares;
  final int? comment;
  final int? likes;
  final int? love;
  final int? dislike;
  final int? otherReactions;
  final bool? isBusinessPost;
  final bool? isPersonalPost;
  final String? timeSince;
  final dynamic userProfile;
  final dynamic post;
  final List<int> taggedUsersPost;

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json["id"],
      commentText: json["comment_text"] == null
          ? []
          : List<dynamic>.from(json["comment_text"]!.map((x) => x)),
      eachMedia: json["each_media"] == null
          ? []
          : List<EachMedia>.from(
              json["each_media"]!.map((x) => EachMedia.fromJson(x))),
      hashtags: json["hashtags"] == null
          ? []
          : List<Hashtag>.from(
              json["hashtags"]!.map((x) => Hashtag.fromJson(x))),
      content: json["content"],
      media: json["media"],
      timeStamp: DateTime.tryParse(json["time_stamp"] ?? ""),
      shares: json["shares"],
      comment: json["comment"],
      likes: json["likes"],
      love: json["love"],
      dislike: json["dislike"],
      otherReactions: json["other_reactions"],
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
        "comment_text": commentText.map((x) => x).toList(),
        "each_media": eachMedia.map((x) => x.toJson()).toList(),
        "hashtags": hashtags.map((x) => x.toJson()).toList(),
        "content": content,
        "media": media,
        "time_stamp": timeStamp?.toIso8601String(),
        "shares": shares,
        "comment": comment,
        "likes": likes,
        "love": love,
        "dislike": dislike,
        "other_reactions": otherReactions,
        "is_business_post": isBusinessPost,
        "is_personal_post": isPersonalPost,
        "time_since": timeSince,
        "user_profile": userProfile,
        "post": post,
        "tagged_users_post": taggedUsersPost.map((x) => x).toList(),
      };

  @override
  String toString() {
    return 'MediaModel(id: $id, commentText: $commentText, eachMedia: $eachMedia, '
        'hashtags: $hashtags, content: $content, media: $media, timeStamp: $timeStamp, '
        'shares: $shares, comment: $comment, likes: $likes, love: $love, dislike: $dislike, '
        'otherReactions: $otherReactions, isBusinessPost: $isBusinessPost, '
        'isPersonalPost: $isPersonalPost, timeSince: $timeSince, userProfile: $userProfile, '
        'post: $post, taggedUsersPost: $taggedUsersPost)';
  }
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
