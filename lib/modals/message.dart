class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});

  Message.fromJson(Map<String, dynamic> m)
      : this(text: m["text"], isMe: m["isMe"]);

  Map<String, dynamic> toJson() {
    final map = {"text": text, "isMe": isMe};
    return map;
  }
}
