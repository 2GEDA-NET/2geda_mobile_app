
import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChartCardDetail extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;

  const ChartCardDetail(
      {super.key, required this.title, required this.artist, required this.imageUrl});

  @override
  State<ChartCardDetail> createState() => _ChartCardDetailState();
}

class _ChartCardDetailState extends State<ChartCardDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(200), // Adjust the height as needed
        child: CustomAppBar(
          image: widget.imageUrl,
          name: widget.title,
          numOfSong: '100 songs',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children:
                  audioList.map((audio) => buildTrackCard(audio)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrackCard(AudioModel audio) {
    return Column(
      children: [
        Container(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: 120,
                    height: 90,
                    imageUrl: audio.coverImage ?? 'default_image_url',
                  ),
                  CachedNetworkImage(
                    width: 110,
                    height: 100,
                    imageUrl: audio.coverImage ?? 'default_image_url',
                  ),
                  CachedNetworkImage(
                    width: 100,
                    height: 105,
                    imageUrl: audio.coverImage ?? 'default_image_url',
                  ),
                ],
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audio.artist,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        audio.title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            height: 0.5, // Set the height of the divider as needed
            color: Colors.grey, // Set the color of the divider
          ),
        ),
      ],
    );
  }

  
}

class CustomAppBar extends StatelessWidget {
  final String image;
  final String name;
  final String numOfSong;

  const CustomAppBar(
      {super.key,
      required this.image,
      required this.name,
      required this.numOfSong});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image), // Background image path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7),
              BlendMode.darken), // Adjust the opacity here
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    numOfSong,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  // Add your button's onPressed functionality here
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.white)), // Border color
                  foregroundColor:
                      MaterialStateProperty.all(Colors.white), // Text color
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.download,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Download all",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
