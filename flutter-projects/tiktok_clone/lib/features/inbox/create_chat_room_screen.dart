import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/models/chat_user_model.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_users_view_model.dart';
import 'package:tiktok_clone/features/inbox/view_models/create_chat_room_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';

class CreateChatRoomScreen extends ConsumerWidget {
  const CreateChatRoomScreen({super.key});

  Future<void> _onUserTap(
    BuildContext context,
    WidgetRef ref,
    ChatUserModel user,
  ) async {
    await ref.read(createChatRoomProvider.notifier).createChatRoom(user);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Create Chat Room with'),
      ),
      body: ref.watch(chatUsersProvider).when(
            data: (data) {
              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  return GestureDetector(
                    onTap: () => _onUserTap(context, ref, user),
                    child: ListTile(
                      leading: Container(
                        width: Sizes.size48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Avatar(
                            uid: user.id,
                            name: user.name,
                            hasAvatar: user.hasAvatar,
                          ),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: Sizes.size1,
                    thickness: Sizes.size1,
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
    );
  }
}
