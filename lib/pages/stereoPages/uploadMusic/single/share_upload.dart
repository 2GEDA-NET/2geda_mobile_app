import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShareUpload extends StatefulWidget {
  const ShareUpload({super.key});

  @override
  State<ShareUpload> createState() => _ShareUploadState();
}

class _ShareUploadState extends State<ShareUpload> {
  List<Color> colors = [
    const Color(0xFF4E0CA2),
    const Color.fromARGB(255, 255, 255, 255)
  ]; // Replace with your desired colors

// Define your 'from' and 'to' positions for the gradient
  AlignmentGeometry from = Alignment.topCenter;
  AlignmentGeometry to = Alignment.bottomCenter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Share',
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
          children: [
            Card(
                elevation: 10,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: from,
                      end: to,
                      colors: colors,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text("Now on 2geda stereo",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white)),
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(alignment: Alignment.topCenter, children: [
                        CachedNetworkImage(
                          imageUrl:
                              "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                          height: 180,
                          width: 190,
                        ),
                        CachedNetworkImage(
                          imageUrl:
                              "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                          height: 200,
                          width: 200,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                              height: 230,
                              width: 220,
                            ),
                            Image.asset(
                              "assets/2geda-purple.png",
                              width: 70,
                            )
                          ],
                        ),
                      ]),
                      const Text("Dance with me",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Faithincrease",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/2geda-purple.png",
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF9E69D2)),
                        child: Center(
                          child: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.share)),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Share",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF9E69D2)),
                        child: Center(
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.download)),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Download",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
