// // post_model.dart
// import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:http/http.dart' as http;

import 'user_model.dart';

const String baseUrl = ApiConfig.baseUrl;

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
      user: User.fromJson(json['user'] ?? {}),
      imageUrl: json['imageUrl'] ??
          '', // provide a default value or handle it accordingly
      role: json['role'] ??
          '', // provide a default value or handle it accordingly
      timeAgo: json['timeAgo'] ??
          '', // provide a default value or handle it accordingly
      text: json['text'] ??
          '', // provide a default value or handle it accordingly
      likes: json['likes'] ??
          0, // provide a default value or handle it accordingly
    );
  }
}

class Post {
  final int id;
  final PostUser user;
  final List<Comment> commentText;
  final List<Media> eachMedia;
  final List<Hashtag> hashtags;
  final String content;
  final String media;
  final DateTime timeStamp;
  final int shares;
  final int comment;
  final int likes;
  final int love;
  final int dislike;
  final int otherReactions;
  final bool isPaid;
  final String postType;
  final bool isBusinessPost;
  final bool isPersonalPost;
  final String timeSince;
  final String formattedTimeSince;
  final UserProfile? userProfile;
  // final PostDetails post;
  final List<int> taggedUsersPost;
  final String formattedHashtags;

  Post({
    required this.id,
    required this.user,
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
    required this.isPaid,
    required this.postType,
    required this.isBusinessPost,
    required this.isPersonalPost,
    required this.timeSince,
    required this.formattedTimeSince,
    required this.userProfile,
    // required this.post,
    required this.taggedUsersPost,
    required this.formattedHashtags,
  });

  static Future<Post> fromJson(Map<String, dynamic> json) async {
    try {
      final id = json['id'] ?? 0;
      // final user = PostUser.fromJson(json['user'] ?? {});

      final authToken = await TokenManager().getToken();
      final user = await PostUser.fromJson(json['user'] ?? {}, authToken!);

      print(user.username);
      print(user.id);
      print(user);

      final commentText = (json['comment_text'] as List<dynamic>?)
              ?.map((item) => Comment.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [];
      final eachMedia = (json['each_media'] as List<dynamic>?)
              ?.map((item) => Media.fromJson(item ?? {}))
              .toList() ??
          [];
      final hashtags = (json['hashtags'] as List<dynamic>?)
              ?.map((item) => Hashtag.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [];
      final content = json['content'] ?? '';
      final media = json['media'] ?? '';
      final timeStamp = json['time_stamp'];
      final DateTime parsedTimeStamp = timeStamp != null
          ? DateTime.tryParse(timeStamp) ?? DateTime.now()
          : DateTime.now();

      final shares = json['shares'] ?? 0;
      final comment = json['comment'] ?? 0;
      final likes = json['likes'] ?? 0;
      final love = json['love'] ?? 0;
      final dislike = json['dislike'] ?? 0;
      final otherReactions = json['other_reactions'] ?? 0;
      final isPaid = json['is_paid'] ?? false;
      final postType = json['post_type'] ?? '';
      final isBusinessPost = json['is_business_post'] ?? false;
      final isPersonalPost = json['is_personal_post'] ?? false;
      final timeSince = json['time_since'] ?? '';
      final formattedTimeSince = timeSince.replaceAll('Â', '');
      final userProfile = json['user_profile'] != null
          ? UserProfile.fromJson(json['user_profile']!)
          : null;

      final taggedUsersPost = (json['tagged_users_post'] as List<dynamic>?)
              ?.map((item) => item as int)
              .toList() ??
          [];

      String getFormattedHashtags() {
        if (hashtags.isNotEmpty) {
          return hashtags.map((hashtag) => hashtag.hashTags).join(' ');
        } else {
          return '';
        }
      }

      return Post(
        id: id,
        user: user,
        commentText: commentText,
        timeStamp: parsedTimeStamp,
        eachMedia: eachMedia,
        hashtags: hashtags,
        content: content,
        media: media,
        shares: shares,
        comment: comment,
        likes: likes,
        love: love,
        dislike: dislike,
        otherReactions: otherReactions,
        isPaid: isPaid,
        postType: postType,
        isBusinessPost: isBusinessPost,
        isPersonalPost: isPersonalPost,
        timeSince: timeSince,
        formattedTimeSince: formattedTimeSince,
        userProfile: userProfile,
        taggedUsersPost: taggedUsersPost,
        formattedHashtags: getFormattedHashtags(),
      );
    } catch (e, stackTrace) {
      print("Error parsing JSON: $e\n$stackTrace");
      throw Exception('Failed to parse JSON');
    }
  }
}

class PostUser {
  final int id;
  final String username;
  final String profileImage;
  String work; // Change the type to String
  final String? lastLogin;
  final String? firstName;
  final String? lastName;

  PostUser({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.work, // Update the type
    this.lastLogin,
    this.firstName,
    this.lastName,
  });

  PostUser._initialize({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.work, // Update the type
    this.lastLogin,
    this.firstName,
    this.lastName,
  });

  // Static method to create an instance asynchronously
  static Future<PostUser> fromJson(
      Map<String, dynamic> json, String authToken) async {
    final id = json['id'];
    final postUserModel = PostUser._initialize(
      id: id ?? 0,
      username: json['username'] ?? 'Anonymous User',
      profileImage: '', // Update this line
      work: '', // Provide a default value or handle it accordingly
    );

    // Fetch artist details and update the artist name
    await postUserModel.fetchUserDetails(authToken);

    return postUserModel;
  }

  Future<void> fetchUserDetails(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users-list/$id/'),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userJson = json.decode(response.body);
      if (userJson['user_profile'] is List) {
        List<dynamic> userProfileList = userJson['user_profile'];
        if (userProfileList.isNotEmpty && userProfileList.first is Map) {
          Map<String, dynamic> userProfile = userProfileList.first;
          work = userProfile['work'] ?? '';
        } else {
          work = ''; // Set a default value or handle it as per your requirement
        }
      } else if (userJson['user_profile'] is Map<String, dynamic>) {
        // Handle the case where 'user_profile' is a map directly
        Map<String, dynamic> userProfile = userJson['user_profile'];
        work = userProfile['work'] ?? '';
      } else {
        work = ''; // Set a default value or handle it as per your requirement
      }
    } else {
      throw Exception('Failed to load artist details');
    }
  }
}

class Media {
  final int user;
  final String media;

  Media({
    required this.user,
    required this.media,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      user:
          json['user'] ?? 0, // provide a default value or handle it accordingly
      media: json['media']?.toString() ??
          '', // convert to String or provide a default value
    );
  }
}

class Hashtag {
  final int id;
  final String user;
  final String hashTags;
  final dynamic post;

  Hashtag(
      {required this.id,
      required this.user,
      required this.hashTags,
      this.post});

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      id: json['id'],
      user: json['user'],
      hashTags: json['hash_tags'],
      post: json['post'],
    );
  }
}
