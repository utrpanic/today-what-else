import 'package:tiktok_clone/features/inbox/models/chat_user_model.dart';

class ChatRoomModel {
  ChatRoomModel({
    required this.id,
    required this.userA,
    required this.userB,
    required this.updatedAt,
  });

  ChatRoomModel.fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) : this(
          id: id,
          userA: ChatUserModel.fromJson(
            json: json['userA'] as Map<String, dynamic>,
          ),
          userB: ChatUserModel.fromJson(
            json: json['userB'] as Map<String, dynamic>,
          ),
          updatedAt: json['updatedAt'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'userA': userA.toJson(),
      'userB': userB.toJson(),
      'updatedAt': updatedAt,
    };
  }

  final String id;
  final ChatUserModel userA;
  final ChatUserModel userB;
  final int updatedAt;

  ChatRoomModel copyWith({
    String? id,
    ChatUserModel? userA,
    ChatUserModel? userB,
    int? updatedAt,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      userA: userA ?? this.userA,
      userB: userB ?? this.userB,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ChatUserModel opponent(String myId) {
    if (userA.id == myId) {
      return userB;
    } else {
      return userA;
    }
  }
}
