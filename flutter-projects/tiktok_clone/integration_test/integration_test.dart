import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.signOut();
  });

  testWidgets('Create Account Flow', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TikTokApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Sign up for TikTok'), findsOneWidget);
    final login = find.text('Log in');
    expect(login, findsOneWidget);
    await tester.tap(login);
    await tester.pumpAndSettle();
    final signUp = find.text('Sign up');
    expect(signUp, findsOneWidget);
    await tester.tap(signUp);
    await tester.pumpAndSettle();
    final emailButton = find.text('Use email & password');
    expect(emailButton, findsOneWidget);
    await tester.tap(emailButton);
    await tester.pumpAndSettle();

    final usernameInput = find.byType(TextField).first;
    await tester.enterText(usernameInput, 'test user name');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    final emailInput = find.byType(TextField).first;
    await tester.enterText(emailInput, 'test@testing.com');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    final passwordInput = find.byType(TextField).first;
    await tester.enterText(passwordInput, '12345678');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('Choose your interests'), findsWidgets);
  });
}
