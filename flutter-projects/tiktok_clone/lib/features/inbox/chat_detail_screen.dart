import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_detail_view_model.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  const ChatDetailScreen({super.key, required this.chatId});

  static const String routeName = 'chatDetail';
  static const String routeURL = ':chatId';

  final String chatId;

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  void _onDeleteMessageLongPress(MessageModel message) {
    final myId = ref.read(authRepo).user!.uid;
    if (message.userId != myId) return;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Do you want to delete this message?'),
        message: const Text(
          'If the messages was sent before 2 minutes, it will be replaced [DELETED].',
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancel'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              ref
                  .read(messagesProvider(widget.chatId).notifier)
                  .deleteMessage(message);
              Navigator.of(context).pop();
            },
            child: const Text('Yes, plz'),
          ),
        ],
      ),
    );
  }

  void _onSendPressed() {
    final text = _editingController.text;
    if (text.isEmpty) return;
    ref.read(messagesProvider(widget.chatId).notifier).sendMessage(text);
    _editingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final messageIsSending =
        ref.watch(messagesProvider(widget.chatId)).isLoading;
    final chatRoom = ref.watch(chatDetailProvider(widget.chatId)).valueOrNull;
    final opponent = chatRoom?.opponent(ref.watch(authRepo).user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              SizedBox(
                width: Sizes.size48,
                height: Sizes.size48,
                child: Avatar(
                  uid: opponent?.id ?? '',
                  name: opponent?.name ?? 'unknown',
                  hasAvatar: opponent?.hasAvatar ?? false,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: Sizes.size16,
                  height: Sizes.size16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            opponent?.name ?? 'unknown',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ref.watch(chatProvider(widget.chatId)).when(
            data: (data) {
              return ListView.separated(
                reverse: true,
                padding: EdgeInsets.only(
                  top: Sizes.size20,
                  left: Sizes.size16,
                  right: Sizes.size16,
                  bottom: MediaQuery.of(context).padding.bottom + Sizes.size96,
                ),
                itemBuilder: (context, index) {
                  final message = data[index];
                  final isMine =
                      message.userId == ref.watch(authRepo).user!.uid;
                  return GestureDetector(
                    onLongPress: () => _onDeleteMessageLongPress(message),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Sizes.size16),
                          decoration: BoxDecoration(
                            color: isMine
                                ? Colors.blue
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(Sizes.size20),
                              topRight: const Radius.circular(Sizes.size20),
                              bottomLeft: isMine
                                  ? const Radius.circular(Sizes.size20)
                                  : Radius.zero,
                              bottomRight: !isMine
                                  ? const Radius.circular(Sizes.size20)
                                  : Radius.zero,
                            ),
                          ),
                          child: Text(
                            message.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: data.length,
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size16,
                        vertical: Sizes.size8,
                      ),
                      child: TextField(
                        controller: _editingController,
                        decoration: const InputDecoration(
                          hintText: 'Send a message...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizes.size20),
                              topRight: Radius.circular(Sizes.size20),
                              bottomLeft: Radius.circular(Sizes.size20),
                              bottomRight: Radius.zero,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Sizes.size8,
                            horizontal: Sizes.size16,
                          ),
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.faceSmile,
                                color: Colors.black,
                              ),
                              Gaps.h16,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: messageIsSending ? null : _onSendPressed,
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.size8),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: FaIcon(
                        messageIsSending
                            ? FontAwesomeIcons.hourglass
                            : FontAwesomeIcons.solidPaperPlane,
                        color: Colors.white,
                        size: Sizes.size20,
                      ),
                    ),
                  ),
                  Gaps.h12,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
