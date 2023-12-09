import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/posts/comment/post_comment.dart';
import 'package:_2geda/pages/widgets/posts/post_header.dart';
import 'package:_2geda/pages/widgets/posts/post_stats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
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
  TextEditingController textController = TextEditingController();
  late RecorderController recorderController;
  late Record audioRecord;
  final TokenManager tokenManager = TokenManager();
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String? authToken;
  bool isWaveformVisible = false;
  bool showAdditionalButtons = true;
  String audioPath = '';
  final PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    recorderController = RecorderController();
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
          isWaveformVisible = true;
        });

        // Open the voice note input dialog when recording starts
        showVoiceNoteInputDialog(context);
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
                    PostHeader(
                      post: widget.post,
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.post.content),
                            Text(widget.post.formattedHashtags)
                          ],
                        )),
                    const SizedBox.shrink(),
                  ],
                ),
                Column(
                  children: (widget.post.eachMedia).map((media) {
                    final imageUrl = media
                        .media; // Assuming 'url' is the property in the Media class that contains the URL
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  child: PostStats(
                    post: widget.post,
                    context: context,
                    postStatsKey: GlobalKey(),
                  ),
                ),
                // FeedComments(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CommentSection(postId: widget.post.id),

          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showAdditionalButtons) ...[
            FloatingActionButton(
              heroTag: "docBtn",
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
                  print(filePath);
                  int postId =
                      widget.post.id; // Replace with the actual post ID
                  String comment = textController.text;
                  List<String> filePaths = [
                    filePath!
                  ]; // Add the file paths as needed

                  try {
                    await postService.createComment(
                        authToken!, postId, comment, filePaths);
                    // Optionally, you can update the UI or show a success message
                  } catch (error) {
                    // Handle the error, show an error message, etc.
                    print('Error creating comment: $error');
                  }
                  // Now you have the file path, you can use it for further processing, like uploading to a server or displaying it.
                }
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.description, color: Colors.black),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
                heroTag: "btn1",
                onPressed: isRecording ? stopRecording : startRecording,
                backgroundColor: const Color.fromARGB(255, 12, 162, 62),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                )),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () async {
                final video =
                    await ImagePicker().pickVideo(source: ImageSource.gallery);
                if (video != null) {
                  int postId =
                      widget.post.id; // Replace with the actual post ID
                  String comment = textController.text;
                  List<String> filePaths = [
                    video.path
                  ]; // Add the file paths as needed

                  try {
                    await postService.createComment(
                        authToken!, postId, comment, filePaths);
                    // Optionally, you can update the UI or show a success message
                  } catch (error) {
                    // Handle the error, show an error message, etc.
                    print('Error creating comment: $error');
                  }
                }
              },
              backgroundColor: const Color.fromARGB(255, 9, 125, 161),
              child: const Icon(
                Icons.tv,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  int postId =
                      widget.post.id; // Replace with the actual post ID
                  String comment = textController.text;
                  List<String> filePaths = [
                    image.path
                  ]; // Add the file paths as needed

                  try {
                    await postService.createComment(
                        authToken!, postId, comment, filePaths);
                    // Optionally, you can update the UI or show a success message
                  } catch (error) {
                    // Handle the error, show an error message, etc.
                    print('Error creating comment: $error');
                  }
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: "btn4",
              onPressed: () {
                // Call a function to show the text input dialog
                showTextInputDialog(context);
              },
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.edit_square,
                color: Colors.white,
              ),
            ),
          ],
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "btnToggle",
            onPressed: () {
              setState(() {
                showAdditionalButtons = !showAdditionalButtons;
              });
            },
            backgroundColor: Colors.blue,
            child: Icon(
              showAdditionalButtons ? Icons.close : Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void showTextInputDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(15),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration:
                      const InputDecoration(hintText: "Write your comment..."),
                ),
              ),
              IconButton(
                onPressed: () async {
                  print(textController.text);
                  int postId =
                      widget.post.id; // Replace with the actual post ID
                  String comment = textController.text;
                  List<String> filePaths = []; // Add the file paths as needed
                  print(authToken);
                  // Close the dialog
                  try {
                    await postService.createComment(
                        authToken!, postId, comment, filePaths);
                    // Optionally, you can update the UI or show a success message
                  } catch (error) {
                    // Handle the error, show an error message, etc.
                    print('Error creating comment: $error');
                  }
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }

  void showVoiceNoteInputDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(15),
          content: Row(
            children: [
              IconButton(
                onPressed: () {
                  // Toggle the recording state
                  if (isRecording) {
                    stopRecording();
                  } else {
                    // Start or resume playing when the button is pressed
                    isRecording ? stopRecording() : playRecording();
                  }
                  // Toggle the recording state
                  setState(() {
                    isRecording = !isRecording;
                  });
                },
                icon: isRecording
                    ? const Icon(
                        Icons.stop,
                        color: Color(0xFF4E0CA2),
                      )
                    : const Icon(
                        Icons.play_arrow,
                        color: Color(0xFF4E0CA2),
                      ),
              ),
              AudioWaveforms(
                enableGesture: true,
                size: Size(MediaQuery.of(context).size.width / 3, 50),
                recorderController: recorderController,
                waveStyle: const WaveStyle(
                  waveColor: Colors.white,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xFF4E0CA2),
                ),
                padding: const EdgeInsets.only(left: 18),
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
              IconButton(
                onPressed: () async {
                  // Stop recording when sending the voice note
                  if (isRecording) {
                    await stopRecording();
                  }

                  // Upload the recorded audio file
                  int postId =
                      widget.post.id; // Replace with the actual post ID
                  String comment = textController.text;
                  List<String> filePaths = [
                    audioPath
                  ]; // Add the file path as needed

                  try {
                    await postService.createComment(
                        authToken!, postId, comment, filePaths);
                    // Optionally, you can update the UI or show a success message
                  } catch (error) {
                    // Handle the error, show an error message, etc.
                    print('Error creating comment: $error');
                  }

                  // Close the dialog
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }
}
