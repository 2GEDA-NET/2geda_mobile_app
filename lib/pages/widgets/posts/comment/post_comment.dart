import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/widgets/posts/profile_avatar.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final List<Comment> comments;

  const CommentSection({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Text(
                "Comments",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "most relevant",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              )
            ],
          ),
        ),
        const Divider(),
        for (final comment in comments) _CommentTile(comment: comment),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              0.02, // 20% of the screen's height
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Load more",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.red,
              decoration: TextDecoration.underline, // Add underline
            ),
          ),
        ),
        Image.asset(
          "assets/banner2.png",
          width: MediaQuery.of(context).size.width,
          height: 60,
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;

  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // Use a Column to stack the header and comment
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CommentHeader(comment: comment), // Place the header here
            const SizedBox(
                height: 20), // Add spacing between header and comment
            Text(comment.text),
            const SizedBox(height: 4),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.thumb_up_outlined,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),
                Text('${comment.likes}'),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  final Comment comment;

  const _CommentHeader({
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: comment.user.userProfile!.userImage.profileImage),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.user.username,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff4e0ca2),
                ),
              ),
              Row(
                children: [
                  Text(
                    comment.user.userProfile!.work,
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
          comment.timeAgo,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
