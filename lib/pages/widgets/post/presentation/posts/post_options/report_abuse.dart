// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:io';

import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ReportAbusePage extends StatefulWidget {
  const ReportAbusePage({super.key});

  @override
  _ReportAbusePageState createState() => _ReportAbusePageState();
}

class _ReportAbusePageState extends State<ReportAbusePage> {
  TextEditingController descriptionController = TextEditingController();
  String selectedFileName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Abuse',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the icon color to black
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text(
                "Your opinions mean a lot to us as a team so as to create a community that is safe for everyone.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Write up to 1000 words',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: [
                      'pdf',
                      'doc',
                      'docx',
                      'txt',
                      'jpg',
                      'png'
                    ], // Customize the allowed file types
                  );

                  if (result != null) {
                    // Process the selected file(s)
                    List<File> files = result.files.map((file) {
                      selectedFileName =
                          file.name; // Update the selected file name
                      return File(file.path!);
                    }).toList();
                    // You can perform actions with the selected files, such as uploading them or processing them.
                  } else {
                    // User canceled file selection
                  }
                  setState(
                      () {}); // Ensure the UI updates to display the selected file name
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffb368ef),
                  minimumSize: const Size(187, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Image/File'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Selected File: $selectedFileName', // Display the selected file name
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              ElevatedButton(
                onPressed: () {
                  showSuccessDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Send report",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Report submitted successfully!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SideBarLayout()),
                (Route<dynamic> route) => false, // Clear the navigation stack
              ); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

}

void main() {
  runApp(const MaterialApp(
    home: ReportAbusePage(),
  ));
}
