// ignore_for_file: library_private_types_in_public_api, unused_local_variable, unused_element

import 'dart:convert';

import 'package:_2geda/pages/authentication/profile/personal_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the HTTP package


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

  // New property to track selected friends
  List<String> selectedFriends = [];

  int wordCount = 0;
  final int maxWordCount = 1000;

  bool hasUpdatedProfile = false;

  @override
  void initState() {
    super.initState();
    checkUserProfileStatus(); // Call the method to check user profile status
    postTextController.addListener(_countWords);
  }

  void checkUserProfileStatus() async {
  try {
    final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_URL_HERE'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Assuming the API response contains a field named 'profileUpdated'
      final profileUpdated = data['has_updated_profile'];

      setState(() {
        hasUpdatedProfile = profileUpdated; // Update the variable
      });
    } else {
      // Handle API error
      print('Failed to fetch profile status. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions (e.g., network errors)
    print('Error: $e');
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

  void _createPost() {
    // Check if the word count exceeds 1000 before posting
    if (wordCount > maxWordCount) {
      // Handle the case where the user exceeded the word limit
      return;
    }

    if (hasUpdatedProfile) {
      Navigator.pop(context);
      // Implement the logic to create and post the content to your backend here.
      // You can use HTTP packages like http or Dio to make API requests.
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
              const HashtagInputTextField(),
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

class ContainerItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color iconColor; // Add a property for the icon color

  const ContainerItem({
    super.key,
    required this.text,
    required this.iconData,
    this.iconColor = const Color(0xff4e0ca2), // Provide a default color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your button's onPressed functionality here
      },
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

class ContainerGrid extends StatelessWidget {
  const ContainerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> containers = [
      const ContainerItem(text: 'Photos', iconData: Icons.image),
      const ContainerItem(text: 'Videos', iconData: Icons.business),
      const ContainerItem(
          text: 'Jobs',
          iconData: Icons.shopping_bag_outlined,
          iconColor: Colors.black),
      const ContainerItem(
        text: 'Music',
        iconData: Icons.music_note,
        iconColor: Colors.red,
      ),
      const ContainerItem(
        text: 'Voice note',
        iconData: Icons.mic_none_outlined,
        iconColor: Colors.black,
      ),
      const ContainerItem(text: 'Word Doc', iconData: Icons.insert_drive_file),
      const ContainerItem(text: 'Excel doc', iconData: Icons.insert_drive_file),
      const ContainerItem(
        text: 'Others',
        iconData: Icons.insert_drive_file,
        iconColor: Colors.black,
      ),
    ];

    // Split the containers into sublists with four items each
    List<List<Widget>?> rows = [];
    for (var i = 0; i < containers.length; i += 4) {
      rows.add(containers.sublist(i, i + 4));
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      children: [
        for (var row in rows)
          Row(
            children: [
              for (var container in row!)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: container,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class HashtagInputTextField extends StatefulWidget {
  const HashtagInputTextField({
    super.key,
  });

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
    }
  }

  void removeHashtag(String tag) {
    setState(() {
      hashtags.remove(tag);
    });
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

              Container(
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
