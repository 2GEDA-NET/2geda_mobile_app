import 'dart:io';
import 'package:_2geda/APIServices/polls_api_service.dart';
import 'package:_2geda/models/polls_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/homeScreens/create_post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({super.key});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final PollApiService pollApiService = PollApiService();
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  List<TextEditingController> optionControllers = [TextEditingController()];
  TextEditingController questionController = TextEditingController();
  String selectedDuration = ''; // Initialize with a default value
  String selectedType = ''; // Initialize with a default value
  String selectedPrivacy = ''; // Initialize with a default value

  // String selectedValue = ''; // Initialize with a default value
  List<String> dropdownduration = ['24 hours', '7 days', '1 month', '6 months'];
  List<XFile?> mediaFiles = [];

  List<String> dropdownPostType = [
    'Free',
    'Paid',
  ];

  List<String> dropdownPostPrivacy = [
    'Public',
    'Private',
  ];

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    if (kDebugMode) {
      print('Auth Token: $authToken');
      print('Token $authToken');
    }
  }

  Future<void> _createPoll() async {
    try {
      final List<String> options =
          optionControllers.map((controller) => controller.text).toList();
// Convert the selected duration to a DateTime object
      DateTime now = DateTime.now();
      DateTime endTime;

      switch (selectedDuration) {
        case '24 hours':
          endTime = now.add(const Duration(hours: 24));
          break;
        case '7 days':
          endTime = now.add(const Duration(days: 7));
          break;
        case '1 month':
          endTime = now.add(const Duration(days: 30));
          break;
        case '6 months':
          endTime = now.add(const Duration(days: 180));
          break;
        default:
          // Handle the case where an unknown duration is selected
          if (kDebugMode) {
            print('Unknown duration selected');
          }
          return;
      }
      // Check if any option is empty
      if (options.any((option) => option.isEmpty)) {
        // Display an error message or handle accordingly
        if (kDebugMode) {
          print('All options must be filled');
        }
        return;
      }

      // Use your API service to create the poll
      final Poll createdPoll = await pollApiService.createPoll(
        question: questionController.text,
        options: options,
        duration: selectedDuration,
        type: selectedType,
        privacy: selectedPrivacy,
        mediaFiles: mediaFiles,
        authToken: authToken!,
        endTime: endTime, // Pass the calculated endTime to the API service
      );

      // Check if the poll was created successfully
      // Poll created successfully, you can navigate to another screen or perform any other action
      if (kDebugMode) {
        print('Poll created successfully');
      }
      Navigator.pop(context);
    } catch (e) {
      // Handle exceptions
      if (kDebugMode) {
        print('Error creating poll: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Poll',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Poll question",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: questionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter your question',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              for (int i = 0; i < optionControllers.length; i++)
                buildOptionTextField(i),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        optionControllers.add(TextEditingController());
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Add option"),
                      ],
                    ),
                  ),
                ],
              ),
              const Text("Poll duration",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: null,
                items: dropdownduration.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      height: 20, // Adjust the height of the DropdownMenuItem
                      child: Center(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDuration = newValue!;
                  });
                },
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Select one',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30, // Adjust the icon size
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Poll type",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: null,
                items: dropdownPostType.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      height: 20, // Adjust the height of the DropdownMenuItem
                      child: Center(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue!;
                  });
                },
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Select one',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30, // Adjust the icon size
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Poll privacy",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: null,
                items: dropdownPostPrivacy.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      height: 20, // Adjust the height of the DropdownMenuItem
                      child: Center(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPrivacy = newValue!;
                  });
                },
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  labelText: 'Select one',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30, // Adjust the icon size
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  _pickMedia();
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Add Image or Video'),
                  ],
                ),
              ),

              // Display selected images or videos
              SizedBox(
                height: 100, // Set the desired height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mediaFiles.length,
                  itemBuilder: (context, index) {
                    final mediaFile = mediaFiles[index];

                    // Check if it's an image or video
                    if (mediaFile?.path.endsWith('.mp4') == true) {
                      // Display VideoPlayer for videos
                      return VideoPlayerWidget(
                          videoFile: File(mediaFile!.path));
                    } else {
                      // Display Image for images
                      return Image.file(File(mediaFile!.path));
                    }
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _createPoll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(250, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: PollApiService.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Create Poll",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionTextField(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Option ${index + 1}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: optionControllers[index],
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Type Option',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  optionControllers.removeAt(index);
                });
              },
              child: const Row(
                children: [
                  Icon(Icons.remove_circle),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Remove option"),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

// Function to handle image or video selection
  Future<void> _pickMedia() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the selected image file
      setState(() {
        mediaFiles.add(pickedFile);
      });
    } else {
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Handle the selected video file
        setState(() {
          mediaFiles.add(pickedFile);
        });
      }
    }
  }
}
