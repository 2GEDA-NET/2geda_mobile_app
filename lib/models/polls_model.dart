class Poll {
  final int id;
  final int countViews;
  final Media media;
  final String question;
  final String duration;
  final String type;
  final DateTime createdAt;
  final bool isActive;
  final bool isEnded;
  final DateTime? endTime;
  final int voteCount;
  final List<dynamic> accessRequests;

  Poll({
    required this.id,
    required this.countViews,
    required this.media,
    required this.question,
    required this.duration,
    required this.type,
    required this.createdAt,
    required this.isActive,
    required this.isEnded,
    required this.endTime,
    required this.voteCount,
    required this.accessRequests,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      countViews: json['count_views'],
      media: Media.fromJson(json['media']),
      question: json['question'],
      duration: json['duration'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      isActive: json['is_active'],
      isEnded: json['is_ended'],
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      voteCount: json['vote_count'],
      accessRequests: json['access_requests'],
    );
  }
}

class Media {
  final int id;
  final String image;

  Media({
    required this.id,
    required this.image,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      image: json['image'],
    );
  }
}
