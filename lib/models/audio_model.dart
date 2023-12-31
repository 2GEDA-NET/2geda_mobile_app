import 'dart:convert';
import 'package:_2geda/APIServices/api_config.dart';
import 'package:http/http.dart' as http;

  const String baseUrl = ApiConfig.baseUrl;


class AudioModel {
  final String title;
  String artist; // Change from 'final' to allow modification
  final int artistId; // Add artistId
  final String? coverImage;
  final String audioFile;
  final String duration;
  final String uploadedAt;
  final int downloadCount;
  final int streamCount;

  AudioModel({
    required this.title,
    required this.artist,
    required this.artistId,
    this.coverImage,
    required this.audioFile,
    required this.duration,
    required this.uploadedAt,
    required this.downloadCount,
    required this.streamCount,
  });

  AudioModel._initialize({
    required this.title,
    required this.artist,
    required this.artistId,
    this.coverImage,
    required this.audioFile,
    required this.duration,
    required this.uploadedAt,
    required this.downloadCount,
    required this.streamCount,
  });

  // Static method to create an instance asynchronously
  static Future<AudioModel> fromJson(Map<String, dynamic> json, String authToken) async {
    final artistId = json['artist'] as int;
    final audioModel = AudioModel._initialize(
      title: json['title'] ?? '',
      artist: '', // Initial value, will be updated in the fetchArtistDetails method
      artistId: artistId,
      coverImage: json['cover_image'] as String?,
      audioFile: json['audio_file'] ?? '',
      duration: json['duration'] ?? '',
      uploadedAt: json['uploaded_at'] ?? '',
      downloadCount: json['download_count'] ?? 0,
      streamCount: json['stream_count'] ?? 0,
    );

    // Fetch artist details and update the artist name
    await audioModel.fetchArtistDetails(authToken);

    return audioModel;
  }

  Future<void> fetchArtistDetails(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stereo/api/artists/$artistId'),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> artistJson = json.decode(response.body);
      artist = artistJson['name'] ?? '';
    } else {
      throw Exception('Failed to load artist details');
    }
  }
}




class ChartItem {
  final String title;
  final String artist;
  final String url;
  final String imageUrl;

  ChartItem({
    required this.title,
    required this.artist,
    required this.url,
    required this.imageUrl,
  });
}
