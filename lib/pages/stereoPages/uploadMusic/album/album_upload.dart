import 'package:_2geda/pages/stereoPages/uploadMusic/single/single_detail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AlbumUpload extends StatelessWidget {
  const AlbumUpload({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> pickAudioFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false, // Allow only one file to be selected
      );

      if (result != null) {
        final file = result.files.first;
        final fileName = file.name;
        // Handle the selected file (e.g., upload it or display its name)
        print("Selected file: $fileName");
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Upload',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/2geda-purple.png'),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select music file",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  "Choose a music file you want to upload. Supported file types include MP3, WAV, and M4A. ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: const Color.fromARGB(255, 235, 234, 234),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: pickAudioFile, // Call the file picker function
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 138, 21, 1.0)),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Tap here to select a file",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Or add existing uploads",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SingleDetailUpload(), // Replace with the actual screen
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff4e0ca2), // Change background color
                    minimumSize:
                        const Size(250, 60), // Increase width and height
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
