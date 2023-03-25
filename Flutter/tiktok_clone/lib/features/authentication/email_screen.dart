import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/form_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = '';

  @override
  void initState() {
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'What is your email?',
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: 'Email',
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
            FormButton(disabled: _username.isEmpty)
          ],
        ),
      ),
    );
  }
}
