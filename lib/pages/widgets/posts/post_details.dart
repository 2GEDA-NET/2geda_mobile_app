// ignore_for_file: unused_local_variable

import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/widgets/posts/comment/post_comment.dart';
import 'package:_2geda/pages/widgets/posts/profile_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:file_picker/file_picker.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    super.initState();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error Start Recording: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioRecord.dispose();
    audioPlayer.dispose();
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error Stopping Recording: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error Playing Recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const desiredWidthPercentage = 0.9; // 90% of the screen width
    const desiredHeightPercentage = 0.3; // 30% of the screen height

    final width = screenWidth * desiredWidthPercentage;
    final height = screenHeight * desiredHeightPercentage;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff8e3bce), Color(0xff5816a2)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Feeds',
          style: TextStyle(
            color: Colors.white, // Text color
            // You can also adjust other text styles such as fontSize, fontWeight, etc.
          ),
        ),
        centerTitle: true, // Center-align the title text
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PostHeader(
                      post: widget.post,
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(widget.post.content),
                            Text(widget.post.hashtags as String),
                          ],
                        )),
                    const SizedBox.shrink(),
                  ],
                ),
                Column(
                  children: (widget.post.eachMedia).map((media) {
                    final imageUrl = media.media; // Assuming 'url' is the property in the Media class that contains the URL
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _PostStats(post: widget.post),
                ),
                // FeedComments(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CommentSection(comments: widget.post.commentText),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'pdf',
                  'doc',
                  'docx',
                  'txt'
                ], // Example file types you want to allow
                allowMultiple: false,
              );

              if (result != null) {
                String? filePath = result.files.single.path;
                // Now you have the file path, you can use it for further processing, like uploading to a server or displaying it.
              }
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.description, color: Colors.black),
          ),
          const SizedBox(height: 16),
          if (isRecording) const Text('Recording in Progress'),
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: isRecording ? stopRecording : startRecording,
            backgroundColor: const Color.fromARGB(255, 12, 162, 62),
            child:
                isRecording ? const Icon(Icons.mic_off) : const Icon(Icons.mic),
          ),
          const SizedBox(height: 16),
          if (!isRecording)
            FloatingActionButton(
                heroTag: "btn_play",
                onPressed: playRecording,
                backgroundColor: const Color.fromARGB(255, 12, 162, 62),
                child: const Icon(Icons.play_arrow)),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () async {
              final video =
                  await ImagePicker().pickVideo(source: ImageSource.gallery);
              if (video != null) {
                // Implement video uploading logic here
              }
            },
            backgroundColor: const Color.fromARGB(255, 9, 125, 161),
            child: const Icon(Icons.tv),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "btn3",
            onPressed: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                // Implement image uploading logic here
              }
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.image),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "btn4",
            onPressed: () {
              // Add your onPressed logic for the first button here
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.edit_square),
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff6e2da2), Color(0xff4e0ca2)],
        ),
      ),
      child: Row(
        children: [
          ProfileAvatar(imageUrl: post.userProfile!.userImage.profileImage),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.user.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  post.userProfile!.work,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Text(
            post.timeSince,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
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
                '${post.likes}',
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
                    label: '${post.likes}',
                    onTap: () => print('Like'),
                  ),
                  _PostButton(
                    icon: Icon(
                      Icons.message_outlined,
                      color: Colors.grey[600],
                      size: 28,
                    ),
                    label: '${post.comment}',
                    onTap: () => print('Comment'),
                  ),
                  _PostButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: Colors.grey[600],
                      size: 28.0,
                    ),
                    label: '${post.shares}',
                    onTap: () => print('Share'),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 50,
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
              },
            )
          ],
        ),
      ],
    );
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
