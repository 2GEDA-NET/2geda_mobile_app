import 'dart:io';
import 'package:_2geda/pages/homeScreens/tag_users.dart';
import 'package:flutter/material.dart';

class UploadLifeStyle extends StatefulWidget {
  final String imagePath;

  const UploadLifeStyle({super.key, required this.imagePath});

  @override
  _UploadLifeStyleState createState() => _UploadLifeStyleState();
}

class _UploadLifeStyleState extends State<UploadLifeStyle> {
  final TextEditingController _textFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> selectedFriends = [];
  bool isTextFieldVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isTextFieldVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TagFriendsPage(
                            initialSelectedFriends: selectedFriends,
                          )));
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(133, 158, 158, 158)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tag",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.person_add, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTextFieldVisible = true;
              });
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(137, 158, 158, 158)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Text",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.person_add, color: Colors.white),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Image.file(
                    File(widget.imagePath),
                    height: MediaQuery.of(context).size.height * 0.75,
                  ),
                ),
                if (isTextFieldVisible)
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Center(
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _textFieldController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your text...',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                if (_textFieldController.text.isNotEmpty)
                  Text(_textFieldController.text,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the button tap
                  if (isTextFieldVisible) {
                    // Do something with the entered text
                    String enteredText = _textFieldController.text;
                    print('Entered Text: $enteredText');
                  } else {
                    // Handle the share button tap
                    // Add your logic here
                    print('Share button tapped');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isTextFieldVisible ? 'Submit Text' : 'Share lifestyle',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
