class Message {
  final String senderName;
  final String message;
  final String time;
  final int unreadCount;

  Message({
    required this.senderName,
    required this.message,
    required this.time,
    required this.unreadCount,
  });
}
