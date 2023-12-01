import 'package:_2geda/APIServices/stereo_api_service.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/stereoPages/stereo.dart';
import 'package:flutter/material.dart';

class TrendingMusicList extends StatefulWidget {
  const TrendingMusicList({Key? key}) : super(key: key);

  @override
  _TrendingMusicListState createState() => _TrendingMusicListState();
}

class _TrendingMusicListState extends State<TrendingMusicList> {
  String? authToken;
  List<AudioModel> audioList = [];
  final TokenManager tokenManager = TokenManager();
  final StereoApiService stereoApiService = StereoApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // You need to obtain the authentication token from somewhere
      authToken = await tokenManager.getToken();
      
      final List<AudioModel> audioModels = await stereoApiService.fetchTopSongAudioList(authToken!);

      setState(() {
        audioList = audioModels.map((audioModel) {
          // Convert AudioModel to AudioData or use it directly based on your needs
          return AudioModel(
            title: audioModel.title,
            artist: audioModel.artist,
            coverImage: audioModel.coverImage ?? 'default_image_url',
            audioFile: audioModel.audioFile,
            duration: audioModel.duration,
            uploadedAt: audioModel.uploadedAt,
            downloadCount: audioModel.downloadCount,
            streamCount: audioModel.streamCount,
            // Add artistId to the AudioData or adjust accordingly
            artistId: audioModel.artistId,
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error as needed
    }
  }

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
