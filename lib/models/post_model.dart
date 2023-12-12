// post_model.dart
import 'package:timeago/timeago.dart' as timeago;
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

  PostUser(
      {this.firstName, this.lastName, this.username, this.work, this.imageUrl});

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

// class Post {
//   int? id;
//   PostUser? user;
//   dynamic reaction;
//   dynamic comments;
//   List<Hashtag>? hashtag;
//   int? sharesCount;
//   List<dynamic>? shares;
//   List<String>? media;
//   String? url;
//   String? content;
//   String? timestamp;
//   bool? isBusinessPost;
//   bool? isPersonalPost;
//   List<dynamic>? taggedUsers;

//   Post({
//     this.id,
//     this.user,
//     this.reaction,
//     this.comments,
//     this.hashtag,
//     this.sharesCount,
//     this.shares,
//     this.media,
//     this.url,
//     this.content,
//     this.timestamp,
//     this.isBusinessPost,
//     this.isPersonalPost,
//     this.taggedUsers,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['post__id'],
//       user: PostUser.fromJson(json['user']),
//       reaction: json['reaction'],
//       comments: json['comments'],
//       hashtag: (json['hashtag'] as List<dynamic>?)
//           ?.map((tag) => Hashtag.fromJson(tag))
//           .toList(),
//       sharesCount: json['shares_count'],
//       shares: json['shares'],
//       media: json['media'],
//       url: json['url'],
//       content: json['content'],
//       timestamp: json['timestamp'],
//       isBusinessPost: json['is_business_post'],
//       isPersonalPost: json['is_personal_post'],
//       taggedUsers: json['tagged_users'],
//     );
//   }
// }

class Post {
  int? id;
  int? postId;
  String? username;
  String? userWork;
  String? userImg;
  String? firstName;
  int? sharesCount;
  int? commentsCount;
  String? lastName;
  String? url;
  String? content;
  String? timestamp;
  List<String>? media;
  String? reaction;
  List<Comment>? comments; // Assuming Comment is a separate class
  String? hashtag;
  bool? isBusinessPost;
  bool? isPersonalPost;
  List<String>? taggedUsers;
  String? eachMediaMedia;

  Post({
    required this.id,
    required this.postId,
    required this.username,
    required this.userWork,
    required this.userImg,
    required this.firstName,
    required this.lastName,
    this.sharesCount,
    this.commentsCount,
    required this.url,
    required this.content,
    required this.timestamp,
    required this.media,
    required this.reaction,
    this.comments,
    required this.hashtag,
    required this.isBusinessPost,
    required this.isPersonalPost,
    required this.taggedUsers,
    required this.eachMediaMedia,
  });

  String get formattedTimestampAgo {
    // Check if timestamp is null
    if (timestamp == null) {
      return 'Unknown time';
    }

    // Parse the timestamp string into a DateTime object manually
    List<String> timeParts = timestamp!.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2].split('.')[0]);
    int milliseconds = int.parse(timeParts[2].split('.')[1]);

    DateTime postTime = DateTime.now().subtract(Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    ));

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the difference between now and the post timestamp
    Duration difference = now.difference(postTime);

    // Use the timeago package to format the difference
    String timeAgo =
        timeago.format(now.subtract(difference), locale: 'en_short');

    // Concatenate "ago" to the formatted timestamp
    return '$timeAgo ago';
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      postId: json['post__id'],
      username: json['post__user__username'],
      userImg: json['post__user__userImg'] ??
          'https://images.unsplash.com/photo-1634926878768-2a5b3c42f139?q=80&w=2200&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      userWork: json['post__user__userWork'],
      firstName: json['post__user__first_name'],
      lastName: json['post__user__last_name'],
      sharesCount: json['shares'],
      commentsCount: json['comments'],
      url: json['post__url'],
      content: json['post__content'],
      timestamp: json['post__timestamp'],
      media: List<String>.from(json['media']),
      reaction: json['post__reaction'],
      hashtag: json['post__hashtag'],
      isBusinessPost: json['post__is_business_post'],
      isPersonalPost: json['post__is_personal_post'],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((commentJson) => Comment.fromJson(commentJson))
          .toList(),
      taggedUsers: (json['post__tagged_users'] as List<dynamic>?)
          ?.map((user) => user.toString())
          .toList(),
      eachMediaMedia: json['each_media__media'],
    );
  }
}
