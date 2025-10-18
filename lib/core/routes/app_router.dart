import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_finder/features/onboarding/presentation/onboarding.dart';
import 'package:pet_finder/pet_finder_app.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ///  Onboarding Screen
      GoRoute(
        path: '/',
        name: 'onboarding',
        pageBuilder: (context, state) => const MaterialPage(
          child: OnboardingScreen(),
        ),
      ),

      ///  Main App with Bottom Navigation
      GoRoute(
        path: '/main',
        name: 'main',
        pageBuilder: (context, state) => const MaterialPage(
          child: PetFinderApp(),
        ),
        routes: [
          /// Home Page
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) => const MaterialPage(
              child: HomePage(),
            ),
          ),

          /// Favorites Page
          GoRoute(
            path: '/favorites',
            name: 'favorites',
            pageBuilder: (context, state) => const MaterialPage(
              child: FavoritesPage(),
            ),
          ),

          /// Messages Page
          GoRoute(
            path: '/messages',
            name: 'messages',
            pageBuilder: (context, state) => const MaterialPage(
              child: MessagesPage(),
            ),
          ),

          /// Profile Page
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) => const MaterialPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),
    ],
  );
}
