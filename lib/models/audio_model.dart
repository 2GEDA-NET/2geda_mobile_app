class AudioModel {
  final String title;
  final String artist;
  final String url;
  final String coverImageUrl;

  AudioModel({
    required this.title,
    required this.artist,
    required this.url,
    required this.coverImageUrl,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      url: json['url'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
    );
  }
}

List<AudioModel> parseAudioList(List<dynamic> list) {
  return list.map((json) => AudioModel.fromJson(json)).toList();
}
