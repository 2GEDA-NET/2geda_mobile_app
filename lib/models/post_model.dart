// import 'dart:convert';

// class Post {
//   int id;
//   PostUser? user;
//   List<CommentText> commentText;
//   List<EachMedia> eachMedia;
//   List<Hashtag> hashtags;
//   String? content;
//   List<Reaction> reaction;
//   int postReactionCount;
//   int? postCommentCount;
//   String? media;
//   DateTime timeStamp;
//   int shares;
//   int comment;
//   int likes;
//   int love;
//   int dislike;
//   int otherReactions;
//   bool isPaid;
//   String postType;
//   bool isBusinessPost;
//   bool isPersonalPost;
//   String timeSince;
//   dynamic userProfile;
//   int? post;
//   List<int> taggedUsersPost;

//   Post({
//     required this.id,
//     required this.user,
//     required this.commentText,
//     required this.eachMedia,
//     required this.hashtags,
//     required this.content,
//     required this.reaction,
//     required this.postReactionCount,
//     required this.postCommentCount,
//     required this.media,
//     required this.timeStamp,
//     required this.shares,
//     required this.comment,
//     required this.likes,
//     required this.love,
//     required this.dislike,
//     required this.otherReactions,
//     required this.isPaid,
//     required this.postType,
//     required this.isBusinessPost,
//     required this.isPersonalPost,
//     required this.timeSince,
//     required this.userProfile,
//     required this.post,
//     required this.taggedUsersPost,
//   });

//   factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         id: json["id"],
//         user: json["user"] == null ? null : PostUser.fromJson(json["user"]),
//         commentText: List<CommentText>.from(
//             json["comment_text"].map((x) => CommentText.fromJson(x))),
//         eachMedia: List<EachMedia>.from(
//             json["each_media"].map((x) => EachMedia.fromJson(x))),
//         hashtags: List<Hashtag>.from(
//             json["hashtags"].map((x) => Hashtag.fromJson(x))),
//         content: json["content"],
//         reaction: List<Reaction>.from(
//             json["Reaction"].map((x) => Reaction.fromJson(x))),
//         postReactionCount: json["post_reaction_count"],
//         postCommentCount: json["post_comment_count"],
//         media: json["media"],
//         timeStamp: DateTime.parse(json["time_stamp"]),
//         shares: json["shares"],
//         comment: json["comment"],
//         likes: json["likes"],
//         love: json["love"],
//         dislike: json["dislike"],
//         otherReactions: json["other_reactions"],
//         isPaid: json["is_paid"],
//         postType: json["post_type"],
//         isBusinessPost: json["is_business_post"],
//         isPersonalPost: json["is_personal_post"],
//         timeSince: json["time_since"].replaceAll('Â', ''),
//         userProfile: json["user_profile"],
//         post: json["post"],
//         taggedUsersPost:
//             List<int>.from(json["tagged_users_post"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user": user?.toJson(),
//         "comment_text": List<dynamic>.from(commentText.map((x) => x.toJson())),
//         "each_media": List<dynamic>.from(eachMedia.map((x) => x.toJson())),
//         "hashtags": List<dynamic>.from(hashtags.map((x) => x.toJson())),
//         "content": content,
//         "Reaction": List<dynamic>.from(reaction.map((x) => x.toJson())),
//         "post_reaction_count": postReactionCount,
//         "post_comment_count": postCommentCount,
//         "media": media,
//         "time_stamp": timeStamp.toIso8601String(),
//         "shares": shares,
//         "comment": comment,
//         "likes": likes,
//         "love": love,
//         "dislike": dislike,
//         "other_reactions": otherReactions,
//         "is_paid": isPaid,
//         "post_type": postType,
//         "is_business_post": isBusinessPost,
//         "is_personal_post": isPersonalPost,
//         "time_since": timeSince,
//         "user_profile": userProfile,
//         "post": post,
//         "tagged_users_post": List<dynamic>.from(taggedUsersPost.map((x) => x)),
//       };
// }

// class CommentText {
//   int id;
//   PostUser user;
//   List<dynamic> reaction;
//   List<dynamic> responses;
//   List<dynamic> media;
//   int reactionCount;
//   int responsesCount;
//   String content;
//   String timestamp;
//   DateTime timeStamp;
//   int post;
//   dynamic parent;
//   String timeSince;

//   CommentText({
//     required this.id,
//     required this.user,
//     required this.reaction,
//     required this.responses,
//     required this.media,
//     required this.reactionCount,
//     required this.responsesCount,
//     required this.content,
//     required this.timestamp,
//     required this.timeStamp,
//     required this.post,
//     required this.parent,
//     required this.timeSince,
//   });

//   factory CommentText.fromRawJson(String str) =>
//       CommentText.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory CommentText.fromJson(Map<String, dynamic> json) => CommentText(
//         id: json["id"],
//         user: PostUser.fromJson(json["user"]),
//         reaction: List<dynamic>.from(json["reaction"].map((x) => x)),
//         responses: List<dynamic>.from(json["responses"].map((x) => x)),
//         media: List<dynamic>.from(json["media"].map((x) => x)),
//         reactionCount: json["reaction_count"],
//         responsesCount: json["responses_count"],
//         content: json["content"],
//         timestamp: json["timestamp"],
//         timeStamp: DateTime.parse(json["time_stamp"]),
//         post: json["post"],
//         parent: json["parent"],
//         timeSince: json["time_since"].replaceAll('Â', ''),

//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user": user.toJson(),
//         "reaction": List<dynamic>.from(reaction.map((x) => x)),
//         "responses": List<dynamic>.from(responses.map((x) => x)),
//         "media": List<dynamic>.from(media.map((x) => x)),
//         "reaction_count": reactionCount,
//         "responses_count": responsesCount,
//         "content": content,
//         "timestamp": timestamp,
//         "time_stamp": timeStamp.toIso8601String(),
//         "post": post,
//         "parent": parent,
//         "time_since": timeSince,
//       };
// }

// class PostUser {
//   int id;
//   String? email;
//   bool isBusiness;
//   bool isPersonal;
//   bool isAdmin;
//   String username;
//   int? phoneNumber;
//   bool isVerified;
//   Address? address;
//   List<dynamic> media;
//   CoverImage? coverImage;
//   dynamic lastSeen;
//   dynamic bio;

//   PostUser({
//     required this.id,
//     required this.email,
//     required this.isBusiness,
//     required this.isPersonal,
//     required this.isAdmin,
//     required this.username,
//     required this.phoneNumber,
//     required this.isVerified,
//     required this.address,
//     required this.media,
//     required this.coverImage,
//     required this.lastSeen,
//     required this.bio,
//   });

//   factory PostUser.fromRawJson(String str) =>
//       PostUser.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
//         id: json["id"],
//         email: json["email"],
//         isBusiness: json["is_business"],
//         isPersonal: json["is_personal"],
//         isAdmin: json["is_admin"],
//         username: json["username"],
//         phoneNumber: json["phone_number"],
//         isVerified: json["is_verified"],
//         address:
//             json["address"] == null ? null : Address.fromJson(json["address"]),
//         media: List<dynamic>.from(json["media"].map((x) => x)),
//         coverImage: json["cover_image"] == null
//             ? null
//             : CoverImage.fromJson(json["cover_image"]),
//         lastSeen: json["last_seen"],
//         bio: json["bio"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "email": email,
//         "is_business": isBusiness,
//         "is_personal": isPersonal,
//         "is_admin": isAdmin,
//         "username": username,
//         "phone_number": phoneNumber,
//         "is_verified": isVerified,
//         "address": address?.toJson(),
//         "media": List<dynamic>.from(media.map((x) => x)),
//         "cover_image": coverImage?.toJson(),
//         "last_seen": lastSeen,
//         "bio": bio,
//       };
// }

// class Address {
//   int id;
//   String country;
//   dynamic city;
//   String currentCity;
//   dynamic streetAddress;
//   dynamic apartmentAddress;
//   dynamic location;
//   dynamic postalCode;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int user;

//   Address({
//     required this.id,
//     required this.country,
//     required this.city,
//     required this.currentCity,
//     required this.streetAddress,
//     required this.apartmentAddress,
//     required this.location,
//     required this.postalCode,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.user,
//   });

//   factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         id: json["id"],
//         country: json["country"],
//         city: json["city"],
//         currentCity: json["current_city"],
//         streetAddress: json["street_address"],
//         apartmentAddress: json["apartment_address"],
//         location: json["location"],
//         postalCode: json["postal_code"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         user: json["user"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "country": country,
//         "city": city,
//         "current_city": currentCity,
//         "street_address": streetAddress,
//         "apartment_address": apartmentAddress,
//         "location": location,
//         "postal_code": postalCode,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "user": user,
//       };
// }

// class CoverImage {
//   int id;
//   String coverImage;
//   int user;

//   CoverImage({
//     required this.id,
//     required this.coverImage,
//     required this.user,
//   });

//   factory CoverImage.fromRawJson(String str) =>
//       CoverImage.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
//         id: json["id"],
//         coverImage: json["cover_image"],
//         user: json["user"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "cover_image": coverImage,
//         "user": user,
//       };
// }

// class EachMedia {
//   int user;
//   String media;

//   EachMedia({
//     required this.user,
//     required this.media,
//   });

//   factory EachMedia.fromRawJson(String str) =>
//       EachMedia.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory EachMedia.fromJson(Map<String, dynamic> json) => EachMedia(
//         user: json["user"],
//         media: json["media"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user,
//         "media": media,
//       };
// }

// class Hashtag {
//   int id;
//   String user;
//   String hashTags;
//   dynamic post;

//   Hashtag({
//     required this.id,
//     required this.user,
//     required this.hashTags,
//     required this.post,
//   });

//   factory Hashtag.fromRawJson(String str) => Hashtag.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
//         id: json["id"],
//         user: json["user"],
//         hashTags: json["hash_tags"],
//         post: json["post"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user": user,
//         "hash_tags": hashTags,
//         "post": post,
//       };
// }

// class Reaction {
//   int id;
//   PostUser user;
//   String reactionType;

//   Reaction({
//     required this.id,
//     required this.user,
//     required this.reactionType,
//   });

//   factory Reaction.fromRawJson(String str) =>
//       Reaction.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
//         id: json["id"],
//         user: PostUser.fromJson(json["user"]),
//         reactionType: json["reaction_type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user": user.toJson(),
//         "reaction_type": reactionType,
//       };
// }

// class PostComment {
//   int id;
//   int userId;
//   int postId;
//   String content;
//   String timestamp;
//   dynamic parentId;
//   int responsesCount;
//   int reactionCount;

//   PostComment({
//     required this.id,
//     required this.userId,
//     required this.postId,
//     required this.content,
//     required this.timestamp,
//     required this.parentId,
//     required this.responsesCount,
//     required this.reactionCount,
//   });

//   factory PostComment.fromRawJson(String str) =>
//       PostComment.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
//         id: json["id"],
//         userId: json["user_id"],
//         postId: json["post_id"],
//         content: json["content"],
//         timestamp: json["timestamp"],
//         parentId: json["parent_id"],
//         responsesCount: json["responses_count"],
//         reactionCount: json["reaction_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "post_id": postId,
//         "content": content,
//         "timestamp": timestamp,
//         "parent_id": parentId,
//         "responses_count": responsesCount,
//         "reaction_count": reactionCount,
//       };
// }
