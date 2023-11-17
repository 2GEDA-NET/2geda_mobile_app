// post_model.dart

import 'user_model.dart';


class Comment {
  final User user;
  final String imageUrl;
  final String role;
  final String timeAgo;
  final String text;
  final int likes;

  Comment({
    required this.user,
    required this.imageUrl,
    required this.role,
    required this.timeAgo,
    required this.text,
    required this.likes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: User.fromJson(json['user']),
      imageUrl: json['imageUrl'],
      role: json['role'],
      timeAgo: json['timeAgo'],
      text: json['text'],
      likes: json['likes'],
    );
  }
}

class PostUser {
  String? firstName;
  String? lastName;
  String? username;
  String? work;
  String? imageUrl;

  PostUser({this.firstName, this.lastName, this.username, this.work, this.imageUrl});

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      work: json['work'],
      imageUrl: json['media'],
    );
  }
}

class Hashtag {
  String? hashtag;

  Hashtag({this.hashtag});

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      hashtag: json['hashtag'],
    );
  }
}

class Post {
  int? id;
  PostUser? user;
  dynamic reaction;
  dynamic comments;
  List<Hashtag>? hashtag;
  int? sharesCount;
  List<dynamic>? shares;
  List<String>? media;
  String? url;
  String? content;
  String? timestamp;
  bool? isBusinessPost;
  bool? isPersonalPost;
  List<dynamic>? taggedUsers;

  Post({
    this.id,
    this.user,
    this.reaction,
    this.comments,
    this.hashtag,
    this.sharesCount,
    this.shares,
    this.media,
    this.url,
    this.content,
    this.timestamp,
    this.isBusinessPost,
    this.isPersonalPost,
    this.taggedUsers,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: PostUser.fromJson(json['user']),
      reaction: json['reaction'],
      comments: json['comments'],
      hashtag: (json['hashtag'] as List<dynamic>?)
          ?.map((tag) => Hashtag.fromJson(tag))
          .toList(),
      sharesCount: json['shares_count'],
      shares: json['shares'],
      media: json['media'],
      url: json['url'],
      content: json['content'],
      timestamp: json['timestamp'],
      isBusinessPost: json['is_business_post'],
      isPersonalPost: json['is_personal_post'],
      taggedUsers: json['tagged_users'],
    );
  }
}
