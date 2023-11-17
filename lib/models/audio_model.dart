class AudioModel {
  final String title;
  final String artist;
  final String? coverImage; // Make it nullable
  final String audioFile;
  final String duration;
  final String uploadedAt;
  final int downloadCount;
  final int streamCount;

  AudioModel({
    required this.title,
    required this.artist,
    this.coverImage, // Allow null
    required this.audioFile,
    required this.duration,
    required this.uploadedAt,
    required this.downloadCount,
    required this.streamCount,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      title: json['title'] ?? '',
      coverImage: json['cover_image'] as String?, // Allow null
      audioFile: json['audio_file'] ?? '',
      duration: json['duration'] ?? '',
      uploadedAt: json['uploaded_at'] ?? '',
      downloadCount: json['download_count'] ?? 0,
      streamCount: json['stream_count'] ?? 0,
      artist: json['artist'] ?? '',
    );
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
