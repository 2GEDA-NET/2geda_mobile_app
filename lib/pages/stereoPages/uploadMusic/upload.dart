import 'package:_2geda/pages/stereoPages/uploadMusic/new_upload.dart';
import 'package:_2geda/pages/widgets/stereo/stereoWidgets/artist_overview.dart';
import 'package:_2geda/pages/widgets/stereo/stereoWidgets/promotion_card.dart';
import 'package:_2geda/pages/widgets/stereo/stereoWidgets/upload_details_card.dart';
import 'package:flutter/material.dart';

class UploadMusicScreen extends StatelessWidget {
  const UploadMusicScreen({super.key});

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
              const Text("Artist Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ArtistOverviewCard(
                        count: '2.5b',
                        text: 'Plays',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ArtistOverviewCard(
                        count: '15',
                        text: 'Playlist entries',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ArtistOverviewCard(
                        count: '28k',
                        text: 'Stickers',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ArtistOverviewCard(
                        count: '200k',
                        text: 'Downloads',
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                child: Image.asset("assets/banner2.png"),
              ),
              const Text("Promotions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PromotionCard(),
                    PromotionCard(),
                    PromotionCard(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Recent Uploads",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text("More",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),
              const Column(
                children: [
                  UploadDetailsCard(),
                  UploadDetailsCard(),
                  UploadDetailsCard(),
                ],
              ),
              Image.asset("assets/banner2.png")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 138, 21, 1.0),
        onPressed: () {
          // Add the functionality you want when the FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewUploadScreen(),
            ),
          );
        },
        child: const Icon(Icons.add), // You can use any icon you prefer
      ),
    );
  }
}
