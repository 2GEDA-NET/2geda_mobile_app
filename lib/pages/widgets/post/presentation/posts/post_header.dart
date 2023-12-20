import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/profile_avatar.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatefulWidget {
  final Post post;

  const PostHeader({
    super.key,
    required this.post,
  });

  @override
  State<PostHeader> createState() => PostHeaderState();
}

class PostHeaderState extends State<PostHeader> {
  String selectedReaction = 'None';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ProfileAvatar(
        //   imageUrl: widget.post.user?.media.isNotEmpty ?? false
        //       ? widget.post.user!.media[0]
        //       : 'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
        // ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.user!.username!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4e0ca2),
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.post.user?.address?.country ?? 'Unknown Country',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          widget.post.timeSince!,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
