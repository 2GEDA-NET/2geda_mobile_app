// ignore_for_file: library_private_types_in_public_api, unused_local_variable, unused_element

import 'dart:convert';
import 'dart:io';

import 'package:_2geda/APIServices/api_config.dart';
import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/pages/authentication/profile/personal_profile_form.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/homeScreens/post_media_buttons.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the HTTP package

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({
    super.key,
  });

  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController postTextController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  List<String> hashtags = [];
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  final String baseUrl = ApiConfig.baseUrl;
  final PostService postService = PostService();
  List<String> receivedHashtags = [];

  // New property to track selected friends
  List<String> selectedFriends = [];

  int wordCount = 0;
  final int maxWordCount = 1000;

  //Set this bck to false
  bool hasUpdatedProfile = false;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
    postTextController.addListener(_countWords);
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');

    // Check if the state is already saved
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedProfileState = prefs.getBool('hasUpdatedProfile');

    if (savedProfileState != null) {
      setState(() {
        hasUpdatedProfile = savedProfileState;
        //set the value back to: savedProfileState
        hasUpdatedProfile = true;
      });
    } else {
      final response = await http.get(
        Uri.parse('$baseUrl/profile/update-status/'),
        headers: {'Authorization': 'Token $authToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          hasUpdatedProfile = data['response'];
        });

        // Save the state for future use
        prefs.setBool('hasUpdatedProfile', hasUpdatedProfile);
      } else {
        print('Failed to load user profile status: ${response.statusCode}');
        print('Failed to load user profile status: ${response.body}');
      }
    }
  }

  @override
  void dispose() {
    postTextController.removeListener(_countWords);
    postTextController.dispose();
    super.dispose();
  }

  void _countWords() {
    final text = postTextController.text;
    final words = text.split(RegExp(r"\s+"));
    setState(() {
      wordCount = words.length;
      // Disable input if word count reaches the limit
      if (wordCount >= maxWordCount) {
        postTextController.text = text;
        postTextController.selection =
            TextSelection.fromPosition(TextPosition(offset: text.length));
      }
    });
  }

  void _createPost() async {
    // Check if the word count exceeds 1000 before posting
    if (wordCount > maxWordCount) {
      // Handle the case where the user exceeded the word limit
      return;
    }

    if (hasUpdatedProfile) {
      final postText = postTextController.text;
      // Collect media files from the MediaUploadModel
      MediaUploadModel model =
          Provider.of<MediaUploadModel>(context, listen: false);

      print('Media Upload Model before createPost: $model');
      // Get all media files
      List<File> allMediaFiles = model.getAllMedia();

      final result = await postService.createPost(
        authToken: authToken!,
        postText: postText,
        hashtags: receivedHashtags,
        allMediaFiles: allMediaFiles,
      );

      if (result['success']) {
        // Successfully created post

        print('Post created successfully');
        Navigator.pop(context);
      } else {
        // Failed to create post
        print('Failed to create post: ${result['error']}');
        // Print the full response body for debugging
        print('Response body: ${result['data']}');

        // Print the error message if available
        if (result['error'] != null) {
          print('Error message: ${result['error']}');
        }
      }
    } else {
      // If the profile is not updated, navigate to the profile update page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileFormPage()),
      );
    }
  }

  void updateHashtags(String text) {
    final words = text.split(RegExp(r'\s+'));
    final newHashtags = words.where((word) => word.startsWith('#')).toList();

    setState(() {
      hashtags = newHashtags;
    });
  }

  void removeHashtag(String tag) {
    final newText = _textEditingController.text.replaceFirst(tag, '');
    _textEditingController.text = newText;

    setState(() {
      hashtags.remove(tag);
    });
  }

  void _navigateToTagFriendsPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TagFriendsPage(initialSelectedFriends: selectedFriends)),
    );

    if (result != null) {
      setState(() {
        selectedFriends = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.white, // Set the background color to transparent
        automaticallyImplyLeading: false, // Remove the back arrow icon
        elevation: 0, // Remove the elevation (shadow)
        toolbarHeight: 100,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update your Feed",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4e0ca2)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "What's going on?",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ), // Change the text color
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: postTextController,
                decoration: const InputDecoration(
                  hintText: 'You can write up to 1000 words',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight, // Align the text to the left
                child: Text('$wordCount/$maxWordCount'),
              ),
              // You can add more UI components for adding images, tags, etc. here.
              const ContainerGrid(),
              const SizedBox(
                height: 10,
              ),
              HashtagInputTextField(
                onHashtagsChanged: (hashtags) {
                  setState(() {
                    receivedHashtags = hashtags;
                  });
                },
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: Stack(
                  alignment:
                      Alignment.centerLeft, // Align the TextButton to the left
                  children: [
                    TextButton(
                      onPressed: _navigateToTagFriendsPage,
                      child: const Text(
                        'Tag Friends',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // Add other content for the container if needed
                  ],
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < selectedFriends.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(
                          label: Text(selectedFriends[i]),
                          onDeleted: () {
                            setState(() {
                              selectedFriends.removeAt(i);
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  if (hasUpdatedProfile) {
                    // Implement logic to upload the post here.
                    _createPost(); // You should define this method to handle post creation.
                  } else {
                    // Navigate to the profile update page.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileFormPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  hasUpdatedProfile ? 'Upload' : 'Update your profile',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaUploadModel extends ChangeNotifier {
  List<XFile>? _images;
  List<XFile>? _videos;
  List<XFile>? _audios;
  List<Uint8List>? _voiceNotes;
  List<File>? _wordDocs;
  List<File>? _excelDocs;

  List<File>? _otherFiles;
  final List<RecorderController> _recorderControllers = [];

  List<RecorderController> get recorderControllers => _recorderControllers;

  List<XFile>? get images => _images;
  List<XFile>? get videos => _videos;
  List<XFile>? get audios => _audios;
  List<File>? get wordDocs => _wordDocs;
  List<File>? get excelDocs => _excelDocs;
  List<File>? get otherFiles => _otherFiles;

  List<Uint8List>? get voiceNotes => _voiceNotes;

  void addImage(XFile image) {
    print('Adding image: $image');
    _images ??= [];
    _images!.add(image);
    notifyListeners();
  }

  void addVideo(XFile video) {
    _videos ??= [];
    _videos!.add(video);
    notifyListeners();
  }

  void addAudio(XFile audio) {
    _audios ??= [];
    _audios!.add(audio);
    notifyListeners();
  }

  void addVoiceNote(Uint8List voiceNote) {
    _voiceNotes ??= [];
    _voiceNotes!.add(voiceNote);
    notifyListeners();
  }

  void addWordDoc(File wordDocs) {
    _wordDocs ??= [];
    _wordDocs!.add(wordDocs);
    notifyListeners();
  }

  void addExcelDoc(File excelDocs) {
    _excelDocs ??= [];
    _excelDocs!.add(excelDocs);
    notifyListeners();
  }

  void addOtherFile(File otherFiles) {
    _otherFiles ??= [];
    _otherFiles!.add(otherFiles);
    notifyListeners();
  }

  void removeMedia({
    int? imageIndex,
    int? videoIndex,
    int? audioIndex,
    int? voiceNoteIndex,
    int? wordDocsIndex,
    int? excelDocsIndex,
  }) {
    if (imageIndex != null) {
      _images?.removeAt(imageIndex);
    }
    if (videoIndex != null) {
      _videos?.removeAt(videoIndex);
    }
    if (audioIndex != null) {
      _audios?.removeAt(audioIndex);
    }
    if (voiceNoteIndex != null) {
      _voiceNotes?.removeAt(voiceNoteIndex);
    }
    if (wordDocsIndex != null) {
      _wordDocs?.removeAt(wordDocsIndex);
    }
    if (excelDocsIndex != null) {
      _excelDocs?.removeAt(excelDocsIndex);
    }

    notifyListeners();
  }

  List<File> getAllMedia() {
    List<File> allMedia = [];

    if (_images != null) {
      allMedia.addAll(_images!.map((image) => File(image.path)));
    }
    if (_videos != null) {
      allMedia.addAll(_videos!.map((video) => File(video.path)));
    }
    if (_audios != null) {
      allMedia.addAll(_audios!.map((audio) => File(audio.path)));
    }
    if (_voiceNotes != null) {
      allMedia
          .addAll(_voiceNotes!.map((voiceNote) => File.fromRawPath(voiceNote)));
    }
    if (_wordDocs != null) {
      allMedia.addAll(_wordDocs!);
    }
    if (_excelDocs != null) {
      allMedia.addAll(_excelDocs!);
    }
    if (_otherFiles != null) {
      allMedia.addAll(_otherFiles!);
    }

    print('All media files: $allMedia');

    return allMedia;
  }

  RecorderController createRecorderController() {
    final controller = RecorderController();
    _recorderControllers.add(controller);
    return controller;
  }

  // Add a method to remove a RecorderController
  void removeRecorderController(RecorderController controller) {
    controller.dispose();
    _recorderControllers.remove(controller);
    notifyListeners();
  }
}

class ContainerItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color iconColor; // Add a property for the icon color
  final Function()? onPressed; // Callback function for onPressed

  const ContainerItem({
    Key? key,
    required this.text,
    required this.iconData,
    this.iconColor = const Color(0xff4e0ca2),
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background color of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius
        ),
        elevation: 0.0, // Remove elevation
        side: const BorderSide(color: Colors.grey, width: 1.0), // Grey border
      ),
      child: SizedBox(
        height: 100, // Set the height of the button
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 20, color: iconColor),
            const SizedBox(height: 4),
            Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({Key? key, required this.videoFile})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.file(widget.videoFile);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HashtagInputTextField extends StatefulWidget {
  final void Function(List<String> hashtags) onHashtagsChanged;

  const HashtagInputTextField({
    Key? key,
    required this.onHashtagsChanged,
  }) : super(key: key);

  @override
  _HashtagInputTextFieldState createState() => _HashtagInputTextFieldState();
}

class _HashtagInputTextFieldState extends State<HashtagInputTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> hashtags = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Wrap(
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10.0,
                runSpacing: 4.0,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8A15),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Add Hashtag',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  for (String tag in hashtags)
                    Chip(
                      label: Text("#$tag",
                          style: const TextStyle(color: Colors.white)),
                      backgroundColor: const Color(0xFFFF8A15),
                      onDeleted: () {
                        removeHashtag(tag);
                      },
                      deleteIcon: const Icon(
                        Icons.close, // Replace with your custom icon
                        size: 18.0, // Adjust the size as needed
                        color: Colors.white, // Customize the color
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      onSubmitted: (text) {
                        addLastWordAsHashtag();
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  void addLastWordAsHashtag() {
    final text = _textEditingController.text;
    final words = text.split(RegExp(r'\s+'));

    if (words.isNotEmpty) {
      var lastWord = words.last;

      if (lastWord.startsWith('#')) {
        lastWord = lastWord.substring(1);
      }

      setState(() {
        hashtags.add(lastWord);
        _textEditingController.clear();
      });

      // Call the callback function to notify the parent widget
      widget.onHashtagsChanged(hashtags);
    }
  }

  void removeHashtag(String tag) {
    setState(() {
      hashtags.remove(tag);
    });

    // Call the callback function to notify the parent widget
    widget.onHashtagsChanged(hashtags);
  }
}

class TagFriendsPage extends StatefulWidget {
  final List<String> initialSelectedFriends;

  const TagFriendsPage({super.key, required this.initialSelectedFriends});

  @override
  _TagFriendsPageState createState() => _TagFriendsPageState();
}

class _TagFriendsPageState extends State<TagFriendsPage> {
  late List<String> selectedFriends;

  @override
  void initState() {
    super.initState();
    // Initialize selectedFriends with the initialSelectedFriends
    selectedFriends = List.from(widget.initialSelectedFriends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tag Friends",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true, // Center the title
          backgroundColor: Colors.white, // Set the background color to white
          elevation: 0,
          iconTheme: const IconThemeData(
              color: Colors.black), // Set the color of icons in the AppBar
        ),
        body: Padding(
          padding: const EdgeInsets.all(20), // Add padding to the entire body
          child: Column(
            children: [
              // Widget for selecting friends, update selectedFriends accordingly
              TextField(
                decoration: InputDecoration(
                  // labelText: "Tag Friends",
                  hintText: "Type a name",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(100.0), // Set the border radius
                  ),
                ),
              ),

              const Expanded(
                child: SizedBox(
                  height: 20,
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the width to the device width
                child: ElevatedButton(
                  onPressed: () {
                    // Add your upload logic here
                    Navigator.pop(context, selectedFriends);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xff4e0ca2), // Set the background color to purple
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20)),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                      fontSize: 20, // Increase the font size
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
