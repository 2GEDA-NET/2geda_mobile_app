import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Trending extends StatelessWidget {
  const Trending({
    super.key,
  }); // Correct the super key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180), // Adjust the height as needed
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children:
                    audioList.map((audio) => buildTrackCard(audio)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/banner2.png"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTrackCard(AudioModel audio) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            width: 100,
            height: 100,
            imageUrl: audio.coverImage ?? 'default_image_url',
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audio.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    audio.artist,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/trendingBg.png"), // Background image path
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Implement your back button functionality here
                  Navigator.pop(
                      context); // This line will navigate back in your app
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const Spacer(),
              Image.asset("assets/2geda-logo.png", width: 50),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Image.asset(
                "assets/music_line.png",
                width: 75,
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trending",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "230 songs",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
