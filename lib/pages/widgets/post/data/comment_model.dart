class CommentModel {
  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
    required this.timestamp,
    required this.parentId,
    required this.responsesCount,
    required this.reactionCount,
  });

  final int? id;
  final int? userId;
  final int? postId;
  final String? content;
  final String? timestamp;
  final dynamic parentId;
  final int? responsesCount;
  final int? reactionCount;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      userId: json["user_id"],
      postId: json["post_id"],
      content: json["content"],
      timestamp: json["timestamp"],
      parentId: json["parent_id"],
      responsesCount: json["responses_count"],
      reactionCount: json["reaction_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "content": content,
        "timestamp": timestamp,
        "parent_id": parentId,
        "responses_count": responsesCount,
        "reaction_count": reactionCount,
      };
}
