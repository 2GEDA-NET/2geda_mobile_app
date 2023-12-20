import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final List<CommentText> commentText;

  const CommentSection({super.key, required this.commentText});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    super.initState();
  }

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
        for (final comment in widget.commentText)
          _CommentTile(comment: comment),
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
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _CommentTile extends StatefulWidget {
  final CommentText comment;

  const _CommentTile({required this.comment});

  @override
  State<_CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<_CommentTile> {
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
            _CommentHeader(
              comment: widget.comment,
            ), // Place the header here
            const SizedBox(
                height: 20), // Add spacing between header and comment
            Text(widget.comment.content!),
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
                Text('${widget.comment.reactionCount}'),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _CommentHeader extends StatefulWidget {
  final CommentText comment;

  const _CommentHeader({
    required this.comment,
  });

  @override
  State<_CommentHeader> createState() => _CommentHeaderState();
}

class _CommentHeaderState extends State<_CommentHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ProfileAvatar(
        //   imageUrl: widget.comment.user!.media.isNotEmpty
        //       ? widget.comment.user!.media[0] ?? "defaultImage.png"
        //       : "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
        // ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comment.user!
                    .username!, // Show loading text if _user is null
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff4e0ca2),
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.comment.user!.address?.country ?? 'Unknown Country',
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
          widget.comment.timeSince!,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
