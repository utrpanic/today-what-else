class MessageModel {
  MessageModel({
    required this.text,
    required this.userId,
    required this.createdAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : this(
          text: json['text'] as String,
          userId: json['userId'] as String,
          createdAt: json['createdAt'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  final String text;
  final String userId;
  final int createdAt;
}
