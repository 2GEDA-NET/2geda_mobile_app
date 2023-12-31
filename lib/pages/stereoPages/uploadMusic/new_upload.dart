import 'package:_2geda/pages/stereoPages/uploadMusic/select_upload.dart';
import 'package:flutter/material.dart';

class NewUploadScreen extends StatelessWidget {
  const NewUploadScreen({super.key});

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
              const Text("Share Your Sound with the World",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Are you an aspiring musician looking to showcase your talent or an established artist ready to release your latest tracks? Our music uploading app is here to help you reach your audience and share your music with the world.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text("Why Choose Us?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 138, 21, 1.0)),
                    child: const Center(
                      child: Text("1",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Easy upload",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "With just a few clicks, you can upload your music,\nwhether it's a single track that you're passionate about \n or a complete album that tells a story.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 138, 21, 1.0)),
                    child: const Center(
                      child: Text("2",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Security and Moderation",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "We prioritize the security and quality of our platform.\n Your uploaded music goes through a moderation\n process to ensure a safe and enjoyable listening\n experience for all users.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 138, 21, 1.0)),
                    child: const Center(
                      child: Text("3",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Flexibility",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Choose between uploading a single or an entire album,\nand let your creativity flow.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SelectUpload(), // Replace with the actual screen
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff4e0ca2), // Change background color
                    minimumSize: const Size(250, 60), // Increase width and height
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset("assets/banner2.png")
            ],
          ),
        ),
      ),
    );
  }
}
