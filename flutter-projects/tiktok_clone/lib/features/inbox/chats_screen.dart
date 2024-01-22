import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/create_chat_room_screen.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_rooms_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  static const String routeName = 'chats';
  static const String routeURL = '/chats';

  @override
  ChatsScreenState createState() => ChatsScreenState();
}

class ChatsScreenState extends ConsumerState<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final Duration _duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Direct Messages'),
        actions: [
          IconButton(
            onPressed: _createChatRoomTap,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: ref.watch(chatRoomsProvider).when(
        data: (data) {
          return AnimatedList(
            key: _key,
            padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
            initialItemCount: data.length,
            itemBuilder: (context, index, animation) {
              final chatRoom = data[index];
              return FadeTransition(
                key: UniqueKey(),
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: _makeTile(index: index, chatRoom: chatRoom),
                ),
              );
            },
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator.adaptive());
        },
        error: (error, stack) {
          return Center(child: Text(error.toString()));
        },
      ),
    );
  }

  Widget _makeTile({required int index, required ChatRoomModel chatRoom}) {
    final myId = ref.read(authRepo).user!.uid;
    final opponent = chatRoom.opponent(myId);
    final date = DateTime.fromMillisecondsSinceEpoch(chatRoom.updatedAt);
    return ListTile(
      onTap: () => _onChatRoomTap(chatRoom),
      onLongPress: () => _deleteChatRoom(index: index, chatRoom: chatRoom),
      leading: Avatar(
        uid: opponent.id,
        name: opponent.name,
        hasAvatar: opponent.hasAvatar,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            opponent.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            DateFormat('yyyy-MM-dd').format(date),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: const Text('Should be the last message'),
    );
  }

  Future<void> _createChatRoomTap() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const CreateChatRoomScreen(),
      ),
    );
    await ref.read(chatRoomsProvider.notifier).refreshChatRooms();
  }

  void _onChatRoomTap(ChatRoomModel chatRoom) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      pathParameters: {'chatId': chatRoom.id},
    );
  }

  void _deleteChatRoom({required int index, required ChatRoomModel chatRoom}) {
    _key.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _makeTile(index: index, chatRoom: chatRoom),
      ),
      duration: _duration,
    );
    ref.read(chatRoomsProvider.notifier).deleteChatRoom(chatRoom.id);
  }
}
