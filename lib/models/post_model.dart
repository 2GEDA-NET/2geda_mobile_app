import 'package:_2geda/models/user_model.dart';

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final List<String> imageUrls; // List of image URLs
  final int likes;
  final List<Comment> comments; // Change this to a list of Comment objects
  final int shares;

  const Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrls, // Change this to a list
    required this.likes,
    required this.comments, // Change this to a list of Comment objects
    required this.shares,
  });
}

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
}
