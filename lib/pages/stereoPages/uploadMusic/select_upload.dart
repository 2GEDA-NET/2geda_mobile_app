import 'package:_2geda/pages/stereoPages/uploadMusic/album/album_detail_ep.dart';
import 'package:_2geda/pages/stereoPages/uploadMusic/single/single_upload.dart';
import 'package:flutter/material.dart';

class SelectUpload extends StatefulWidget {
  const SelectUpload({super.key});

  @override
  State<SelectUpload> createState() => _SelectUploadState();
}

class _SelectUploadState extends State<SelectUpload> {
  int? selectedUpload;

  // Define the active and inactive styles for the radio buttons
  final TextStyle activeTextStyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
  final TextStyle inactiveTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
  final Color activeBackgroundColor =
      const Color(0xff4e0ca2); // Change to your desired color
  final Color inactiveBackgroundColor = const Color(0x19000000);

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select a mode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  "Choose between uploading a single or an entire album, and let your creativity flow.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  )),
              const SizedBox(
                height: 30,
              ),
              _buildRadioContainer(1, 'Single'),
              const SizedBox(
                height: 10,
              ),
              _buildRadioContainer(2, 'Album/EP'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedUpload == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SingleUpload(), // Replace with the actual screen
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AlbumEpUpload(), // Replace with the actual screen
                        ),
                      );
                    }
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Image.asset("assets/banner2.png")
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioContainer(int value, String label) {
    final isSelected = selectedUpload == value;
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        left: 20,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: isSelected ? activeBackgroundColor : inactiveBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the children vertically.
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Center the children horizontally.
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                  )),
              Text(
                label,
                style: isSelected ? activeTextStyle : inactiveTextStyle,
              ),
              const SizedBox(
                width: 30,
              ),
              Radio(
                value: value,
                groupValue: selectedUpload,
                activeColor: Colors.white,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedUpload = newValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
