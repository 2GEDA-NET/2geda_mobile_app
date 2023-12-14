import 'package:_2geda/data/audio_data.dart';
import 'package:_2geda/pages/stereoPages/stereo.dart';
import 'package:flutter/material.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: audioList.map((audio) {
          return MusicCard(
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