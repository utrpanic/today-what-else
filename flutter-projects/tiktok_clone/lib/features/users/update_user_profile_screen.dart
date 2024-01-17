import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class UpdateUserProfileScreen extends ConsumerStatefulWidget {
  const UpdateUserProfileScreen({super.key});

  @override
  UpdateUserProfileScreenState createState() => UpdateUserProfileScreenState();
}

class UpdateUserProfileScreenState
    extends ConsumerState<UpdateUserProfileScreen> {
  late final TextEditingController _bioController;
  late final TextEditingController _linkController;

  late String _bio;
  late String _link;

  @override
  void initState() {
    _bio = ref.read(usersProvider).value?.bio ?? '';
    _link = ref.read(usersProvider).value?.link ?? '';
    _bioController = TextEditingController(text: _bio);
    _linkController = TextEditingController(text: _link);
    _bioController.addListener(() {
      setState(() {
        _bio = _bioController.text;
      });
    });
    _linkController.addListener(() {
      setState(() {
        _link = _linkController.text;
      });
    });
    super.initState();
  }

  Future<void> _onSaveButtonTap() async {
    await ref
        .read(usersProvider.notifier)
        .updateProfile(bio: _bio, link: _link);
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'Update your bio and link',
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _bioController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: 'Bio',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _linkController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: 'Link',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Gaps.v28,
            GestureDetector(
              onTap: _onSaveButtonTap,
              child: FormButton(
                text: 'Save',
                disabled: _bio.isEmpty || _link.isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
