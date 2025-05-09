import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/notifications/notifications_provider.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          ref.read(notificationsProvider(context));
          return child;
        },
        routes: [
          GoRoute(
            name: SignUpScreen.routeName,
            path: SignUpScreen.routeURL,
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            name: LoginScreen.routeName,
            path: LoginScreen.routeURL,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            name: InterestsScreen.routeName,
            path: InterestsScreen.routeURL,
            builder: (context, state) => const InterestsScreen(),
          ),
          GoRoute(
            name: MainNavigationScreen.routeName,
            path: '/:tab(home|discover|inbox|profile)',
            builder: (context, state) {
              final tab = state.pathParameters['tab']!;
              return MainNavigationScreen(tab: tab);
            },
          ),
          GoRoute(
            name: ActivityScreen.routeName,
            path: ActivityScreen.routeURL,
            builder: (context, state) => const ActivityScreen(),
          ),
          GoRoute(
            name: ChatsScreen.routeName,
            path: ChatsScreen.routeURL,
            builder: (context, state) => const ChatsScreen(),
            routes: [
              GoRoute(
                name: ChatDetailScreen.routeName,
                path: ChatDetailScreen.routeURL,
                builder: (context, state) {
                  final chatId = state.pathParameters['chatId']!;
                  return ChatDetailScreen(
                    chatId: chatId,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: VideoRecordingScreen.routeName,
            path: VideoRecordingScreen.routeURL,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              child: const VideoRecordingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final position = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: position,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    ],
  );
});
