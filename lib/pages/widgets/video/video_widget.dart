import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:_2geda/data/video_data.dart';
import 'package:_2geda/models/video_model.dart';

class VideoListWidget extends StatelessWidget {
  const VideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Horizontal scroll
      child: Row(
        children: <Widget>[
          for (final video in videoList) VideoCardWidget(video: video),
        ],
      ),
    );
  }
}

class VideoCardWidget extends StatelessWidget {
  final Video video;

  const VideoCardWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: 200, // Set the desired width of the card
                height: 218, // Set the desired height of the card
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: video.coverImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.black.withOpacity(
                        0.4), // Adjust overlay color and opacity as needed
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff4e0ca2).withOpacity(
                          0.6), // Adjust the background color and opacity as needed
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 48, // Set the desired size of the play icon
                      color: Colors
                          .white, // Set the desired color of the play icon
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                // right: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite,
                    size: 24, // Set the desired size of the love icon
                    color: Colors.red, // Set the desired color of the love icon
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '(${video.year})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
