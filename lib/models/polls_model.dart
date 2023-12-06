class Poll {
  final int id;
  final int countViews;
  final Media media;
  final String question;
  final String username;
  final String profileImage;
  final String duration;
  final String privacy;
  final String remainingDays;
  final List<Option> options;
  final List<Option>? optionsList;
  final String type;
  final DateTime createdAt;
  final String timeSince;
  final bool isActive;
  final bool isEnded;
  final DateTime? endTime;
  final int voteCount;
  final List<dynamic> accessRequests;

  Poll({
    required this.id,
    required this.countViews,
    required this.media,
    required this.username,
    required this.profileImage,
    required this.question,
    required this.duration,
    required this.privacy,
    required this.remainingDays,
    required this.options,
    required this.optionsList,
    required this.type,
    required this.createdAt,
    required this.timeSince,
    required this.isActive,
    required this.isEnded,
    required this.endTime,
    required this.voteCount,
    required this.accessRequests,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    final List<Option> optionsList =
        (json['options_list'] as List<dynamic>?)
              ?.map((option) => Option.fromJson(option))
              .toList() ??
          [];

    final int voteCount = optionsList.isNotEmpty ? optionsList.first.allVote : 0;

    return Poll(
      id: json['id'] ?? 0,
      countViews: json['count_views'] ?? 0,
      media: Media.fromJson(json['media'] ?? {}),
      username: json['username'] ?? '',
      profileImage: json['profile_image'] ?? 'https://images.unsplash.com/photo-1634926878768-2a5b3c42f139?q=80&w=2200&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      question: json['question'] ?? '',
      duration: json['duration'] ?? '',
      privacy: json['privacy'] ?? '',
      remainingDays: json['remaining_time'] ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((option) => Option.fromJson(option))
              .toList() ??
          [],
      optionsList: optionsList,
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      isActive: json['is_active'] ?? false,
      isEnded: json['is_ended'] ?? false,
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      voteCount: voteCount,
      accessRequests: json['access_requests'] ?? [],
      timeSince: json['time_since'] ?? '',
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
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}

class Option {
  final int id;
  final String content;
  final String optionImage;
  final int allVote;
  final List<dynamic> votee;

  Option({
    required this.id,
    required this.content,
    required this.optionImage,
    required this.allVote,
    required this.votee,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      optionImage: json['option_image'] ?? '',
      allVote: json['all_vote'] ?? 0,
      votee: json['votee'] ?? [],
    );
  }
}


class OptionList {
  final int id;
  final String content;
  final String optionImage;
  final int allVote;
  final List<dynamic> votee;

  OptionList({
    required this.id,
    required this.content,
    required this.optionImage,
    required this.allVote,
    required this.votee,
  });

  factory OptionList.fromJson(Map<String, dynamic> json) {
    return OptionList(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      optionImage: json['option_image'] ?? '',
      allVote: json['all_vote'] ?? 0,
      votee: json['votee'] ?? [],
    );
  }
}
