class ChatUserModel {
  ChatUserModel({
    required this.id,
    required this.name,
    required this.hasAvatar,
  });

  ChatUserModel.fromJson({
    required Map<String, dynamic> json,
  }) : this(
          id: json['id'] as String,
          name: json['name'] as String,
          hasAvatar: json['hasAvatar'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hasAvatar': hasAvatar,
    };
  }

  final String id;
  final String name;
  final bool hasAvatar;
}
