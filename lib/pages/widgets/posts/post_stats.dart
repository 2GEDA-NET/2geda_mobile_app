import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/widgets/posts/post_options/report_abuse.dart';
import 'package:_2geda/pages/widgets/posts/post_button.dart';

class PostStats extends StatefulWidget {
  final Post post;
  final BuildContext context;
  final GlobalKey postStatsKey;

  const PostStats({
    required this.post,
    required this.postStatsKey,
    required this.context,
  });

  @override
  State<PostStats> createState() => _PostStatsState();
}

class _PostStatsState extends State<PostStats> {
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  String selectedReaction = 'None';
  OverlayEntry? overlayEntry;
  PostService postService = PostService(); // Create an instance of PostService

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.postStatsKey,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3.0),
              decoration: const BoxDecoration(
                color: Color(0xff4e0ca2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${widget.post.likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  PostButton(
                    icon: Icon(
                      getReactionIcon(selectedReaction),
                      color: Colors.grey[600],
                      size: 28.0,
                    ),
                    label: '${widget.post.likes}',
                    onTap: () {
                      handleReactionSelection(
                          'Like'); // Directly handle 'Like' reaction on tap
                      Navigator.pop(context);
                    },
                    onLongPress: () {
                      showReactionMenu(
                          context); // Show the reaction menu on long press
                    },
                  ),
                  PostButton(
                    icon: Icon(
                      Icons.message_outlined,
                      color: Colors.grey[600],
                      size: 28,
                    ),
                    label: '${widget.post.comment}',
                    onTap: () => print('Comment'),
                    onLongPress: () {},
                  ),
                  PostButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: Colors.grey[600],
                      size: 28.0,
                    ),
                    label: '${widget.post.shares}',
                    onTap: () => print('Share'),
                    onLongPress: () {},
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 60,
            ),
            IconButton(
              icon: Icon(
                Icons.more_horiz_outlined,
                color: Colors.grey[600],
                size: 28.0,
              ),
              onPressed: () {
                _showPostOptionsDialog(context);
              },
            )
          ],
        ),
      ],
    );
  }

  void showReactionMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Wrap(
                  children: [
                    buildReactionMenuItem('Like', context, Icons.thumb_up),
                    buildReactionMenuItem('Dislike', context, Icons.thumb_down),
                    buildReactionMenuItem('Love', context, Icons.favorite),
                    buildReactionMenuItem(
                        'Angry', context, Icons.sentiment_very_dissatisfied),
                    buildReactionMenuItem(
                        'Laugh', context, Icons.sentiment_very_satisfied),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((selectedReaction) {
      if (selectedReaction != null) {
        handleReactionSelection(selectedReaction);
      }
    });
  }

  IconData getReactionIcon(String selectedReaction) {
    switch (selectedReaction) {
      case 'Like':
        return Icons.thumb_up;
      case 'Dislike':
        return Icons.thumb_down;
      case 'Love':
        return Icons.favorite;
      case 'Angry':
        return Icons.sentiment_very_dissatisfied;
      case 'Laugh':
        return Icons.sentiment_very_satisfied;
      default:
        return Icons.thumb_up_outlined; // Default or fallback icon
    }
  }

  Widget buildReactionMenuItem(
      String reaction, BuildContext context, IconData iconData) {
    return IconButton(
      onPressed: () {
        handleReactionSelection(reaction);
      },
      icon: Icon(
        iconData,
        color: Color(0xFF4E0CA2),
        size: 28.0,
      ),
    );
  }

  void handleReactionSelection(String reaction) {
    // Handle the selected reaction here
    print('Selected reaction: $reaction');
    print('Selected post id: ${widget.post.id}');
    postService.addReaction(authToken!, widget.post.id, reaction);
    setState(() {
      selectedReaction = reaction; // Update the class-level variable
    });
    Navigator.pop(context);
  }

  void _showPostOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Option 1");
              },
              child: const Text(
                "Promote post",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportAbusePage()),
                );
              },
              child: const Text(
                "Report Abuse",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Option 3");
              },
              child: const Text(
                "See more of this",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Option 4");
              },
              child: const Text(
                "Save Post",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Option 5");
              },
              child: const Text(
                "Block User",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    ).then((result) {
      if (result != null) {
        print("Selected Option: $result");
      }
    });
  }
}
