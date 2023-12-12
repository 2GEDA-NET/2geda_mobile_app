import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:flutter/material.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Verification',
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account Verification",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "To verify your account, certain procedures are required and that will determine if we’ll verify your account or not",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                // labelText: "Tag Friends",
                hintText: "Type a name",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set the border radius
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                // labelText: "Tag Friends",
                hintText: "Type a name",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set the border radius
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "Please paste Three(3) Links where your name has been mentioned and your picture(s) Show clearly. These context must be of a good reputation and contribution to the Community.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Link 1",
                hintText: "Type a link",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Link 2",
                hintText: "Type a link",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Link 3",
                hintText: "Type a link",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Upload a clear front picture of any Government issued ID : Show details clearly.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt_outlined, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Select file",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SideBarLayout(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(300, 60),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(30),
                  // ),
                ),
                child: const Text(
                  "Send request",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
