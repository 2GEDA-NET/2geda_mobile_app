// ignore_for_file: unused_import

import 'dart:math';

import 'package:_2geda/SideBar/bloc_navigation/navigation_bloc.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/widgets/posts/post_details.dart';
import 'package:_2geda/pages/widgets/posts/post_options/report_abuse.dart';
import 'package:_2geda/pages/widgets/posts/profile_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContainer extends StatefulWidget {
  final Post post;
  final int columns; // Number of columns in the image grid

  const PostContainer({
    Key? key,
    required this.post,
    this.columns = 3, // Default to 3 columns
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  int initialImageCount = 5; // Display only the first 4 images
  int imagesPerPage = 6; // Number of images to load per pagination
  int remainingImagesCount = 0; // Initialize remaining images count to 0
  late NavigationBloc navigationBloc; // Declare navigationBloc here

  bool showFullCaption = false; // Track whether to show full caption

  String paginateCaption(String caption, int wordCount) {
    List<String> words = caption.split(' ');
    if (words.length <= wordCount || showFullCaption) {
      return caption;
    } else {
      return '${words.sublist(0, wordCount).join(' ')}...';
    }
  }

  @override
  void initState() {
    super.initState();

    // Calculate the number of remaining images
    remainingImagesCount = (widget.post.media?.length ?? 0) - initialImageCount;
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const desiredWidthPercentage = 0.9; // 90% of the screen width
    const desiredHeightPercentage = 0.3; // 30% of the screen height

    final width = screenWidth * desiredWidthPercentage;
    final height = screenHeight * desiredHeightPercentage;

    // Calculate the number of rows based on the number of columns
    int rows = (widget.post.media?.length ?? 0 / widget.columns).ceil();

    // Create a list of rows, each containing a sublist of images
    List<List<String>> imageRows = [];
    for (int i = 0; i < rows; i++) {
      int start = i * widget.columns;
      int end = (i + 1) * widget.columns;
      if (end > (widget.post.media?.length ?? 0)) {
        end = (widget.post.media?.length ?? 0);
      }
      if (widget.post.media != null) {
        imageRows.add(widget.post.media!.sublist(start, end));
      }
    }

    return GestureDetector(
      onTap: () {
        // Navigate to the post details page when clicked
        // final bloc = BlocProvider.of<NavigationBloc>(context);
        // bloc.add(NavigationEvents.PostDetailClickEvent);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostDetailsPage(post: widget.post),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PostHeader(
                      post: widget.post,
                    ),
                    const SizedBox(height: 26.0),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                paginateCaption(widget.post.content ?? '', 20),
                            style: DefaultTextStyle.of(context).style,
                          ),
                          if ((widget.post.content?.split(' ').length ?? 0) > 20 &&
                              !showFullCaption)
                            TextSpan(
                              text: ' Read More',
                              style: const TextStyle(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.7), // Customize the text color
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    showFullCaption = true;
                                  });
                                },
                            ),
                        ],
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
              const SizedBox(height: 17.0),
              if ((widget.post.media?.length ?? 0) <= initialImageCount) // Display all images
                Column(
                  children: [
                    for (List<String> sublist in imageRows)
                      Row(
                        children: [
                          for (String imageUrl in sublist)
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      1000.0), // Adjust the radius as needed
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: width /
                                      widget
                                          .columns, // Distribute width equally
                                  height: height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                )
              else // Display paginated images
                Column(
                  children: [
                    // Display the first 4 images in rows with three columns
                    Row(
                      children: [
                        for (int i = 0;
                            i < min(4, imageRows[0].length);
                            i++) // Use min to avoid exceeding the list length
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: imageRows[0]
                                  [i], // Image URLs from the first row
                              width: width / widget.columns,
                              height: height,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                    // Display the remaining images count on top of the last displayed image
                    if (remainingImagesCount > 0)
                      Container(
                        alignment: Alignment.center,
                        color: Colors.black
                            .withOpacity(0.6), // Add background color
                        child: Text(
                          '+$remainingImagesCount', // Display remaining count
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 17.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: _PostStats(post: widget.post),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user?.imageUrl ?? ''),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user?.username ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4e0ca2),
                ),
              ),
              Row(
                children: [
                  Text(
                    post.user?.work ?? '',
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
          post.timestamp ?? '',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                '${post.reaction}',
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
                  _PostButton(
                    icon: Icon(
                      Icons.thumb_up_outlined,
                      color: Colors.grey[600],
                      size: 28.0,
                    ),
                    label: '${post.reaction}',
                    onTap: () => print('Like'),
                  ),
                  _PostButton(
                    icon: Icon(
                      Icons.message_outlined,
                      color: Colors.grey[600],
                      size: 28,
                    ),
                    label: '${post.comments.length}',
                    onTap: () => print('Comment'),
                  ),
                  _PostButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: Colors.grey[600],
                      size: 28.0,
                    ),
                    label: '${post.sharesCount}',
                    onTap: () => print('Share'),
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
                // Add your onPressed logic here
                // This function will be called when the button is pressed.
                _showPostOptionsDialog(context);
              },
            )
          ],
        ),
      ],
    );
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
                  MaterialPageRoute(builder: (context) => ReportAbusePage()),
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
      // Handle the selected option here if needed
      if (result != null) {
        print("Selected Option: $result");
        // You can perform an action based on the selected option.
      }
    });
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;

  const _PostButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
