class Message {
  final String text;
  final bool isMe;

  Message.fromJson(Map<String, dynamic> m)
      : this(text: m["text"], isMe: m["isMe"]);

  Message({
    required this.text,
    required this.isMe,
  });
}
