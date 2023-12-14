
import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/pages/stereoPages/stereo.dart';
import 'package:flutter/material.dart';

class LocalMusicCardList extends StatelessWidget {
  const LocalMusicCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: audioList.map((audio) {
          return LocalMusicCard(
            title: audio.title,
            artist: audio.artist,
            url: audio.audioFile,
            imageUrl: audio.coverImage ?? 'default_image_url',
          );
        }).toList(),
      ),
    );
  }
}

