class MessageModel {
  MessageModel({
    required this.id,
    required this.text,
    required this.userId,
    required this.createdAt,
  });

  MessageModel.fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) : this(
          id: id,
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

  final String id;
  final String text;
  final String userId;
  final int createdAt;

  MessageModel copyWith({
    String? id,
    String? text,
    String? userId,
    int? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
