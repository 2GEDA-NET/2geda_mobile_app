import 'package:_2geda/pages/widgets/stereo/stereoWidgets/upload_details_card.dart';
import 'package:flutter/material.dart';

class RecentUpload extends StatelessWidget {
  const RecentUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Recent Upload',
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
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for music',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    UploadDetailsCard(),
                    UploadDetailsCard(),
                    UploadDetailsCard(),
                    UploadDetailsCard(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset("assets/banner2.png"),
          ],
        ),
      ),
    );
  }
}
