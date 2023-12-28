enum MediaType {
  image,
  video,
}

class Story {
  final String? image;
  final MediaType? media;
  final Duration? duration;

  const Story({
    this.image,
    this.media,
    this.duration,
  });
}

final List<Story> stories = [
  const Story(
    image: 'assets/nothing_here.png',
    media: MediaType.image,
    duration: Duration(seconds: 7),
  ),
  const Story(
    image: 'assets/2geda-purple.png',
    media: MediaType.image,
    duration: Duration(seconds: 7),
  ),
];
