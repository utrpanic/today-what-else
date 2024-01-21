class MessageModel {
  MessageModel({
    required this.text,
    required this.userId,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : this(
          text: json['text'] as String,
          userId: json['userId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'userId': userId,
    };
  }

  final String text;
  final String userId;
}
