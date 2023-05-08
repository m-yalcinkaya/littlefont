class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});

  Message.fromMap(Map<String, dynamic> m)
      : this(text: m["text"], isMe: m["isMe"]);

  Map<String, dynamic> toMap() {
    final map = {"text": text, "isMe": isMe};
    return map;
  }
}
