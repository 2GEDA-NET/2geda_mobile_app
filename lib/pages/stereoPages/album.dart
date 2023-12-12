
import 'package:_2geda/data/audio_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: audioList.map((audio) {
          return AlbumCard(
            title: audio.title,
            artist: audio.artist,
            imageUrl: audio.coverImage ?? 'default_image_url',
            url: audio.audioFile,
          );
        }).toList(),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final String url;

  const AlbumCard(
      {super.key,
      required this.title,
      required this.artist,
      required this.url,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: 200,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("Are we annoyed?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(
            height: 5,
          ),
          const Text("Billie Eilish",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}

