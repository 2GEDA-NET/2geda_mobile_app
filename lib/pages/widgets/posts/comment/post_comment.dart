import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/models/user_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/posts/profile_avatar.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final int postId;

  const CommentSection({super.key, required this.postId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  late List<CommentText> _comments = [];
  final TokenManager tokenManager = TokenManager();
  final PostService postService = PostService();
  String? authToken;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');
    await _fetchComments(); // Call _fetchComments to initialize _comments list
  }

  Future<void> _fetchComments() async {
    try {
      print(
          'Fetching comments for post ID: ${widget.postId}, authToken: $authToken');
      // Fetch comments based on the post ID

      List<CommentText> comments =
          await postService.getComments(authToken!, widget.postId);
      print('Fetched comments: $comments');

      // Fetch user details for each comment

      setState(() {
        _comments = comments;
      });
    } catch (error) {
      // Handle the error, show an error message, etc.
      print('Error fetching comments: $error');
    }
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
        for (final comment in _comments) _CommentTile(comment: comment),
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
            Text(widget.comment.content),
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
  late User? _user; 
  final TokenManager tokenManager = TokenManager();
  final PostService postService = PostService();
  String? authToken;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');
    }

 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          imageUrl:
              _user?.userProfile?.userImage.profileImage ?? "defaultImage.png",
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _user?.username ??
                    'Loading...', // Show loading text if _user is null
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff4e0ca2),
                ),
              ),
              Row(
                children: [
                  Text(
                    _user?.userProfile?.work ?? '',
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
          widget.comment.timestamp,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
