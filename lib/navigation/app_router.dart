// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;
  AppRouter({
    required this.appStateManager,
    required this.profileManager,
    required this.groceryManager,
  });

  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: appStateManager,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: "login",
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) {
            return const OnboardingScreen();
          }),
      GoRoute(
        path: '/:tab',
        name: 'home',
        builder: (context, state) {
          final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
          return Home(
            key: state.pageKey,
            currentTab: tab,
          );
        },
        routes: [
          GoRoute(
            path: 'item/:id',
            name: 'item',
            builder: (context, state) {
              final itemId = state.params['id'] ?? '';
              final item = groceryManager.getGroceryItem(itemId);
              return GroceryItemScreen(
                  onCreate: (item) {
                    groceryManager.addItem(item);
                  },
                  onUpdate: (item) {
                    groceryManager.updateItem(item);
                  },
                  originalItem: item);
            },
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) {
              final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
              return ProfileScreen(
                user: profileManager.getUser,
                currentTab: tab,
              );
            },
            routes: [
              GoRoute(
                path: 'rw',
                name: 'rw',
                builder: (context, state) {
                  return const WebViewScreen();
                },
              ),
            ],
          )
        ],
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Error: ${state.error.toString()}'),
          ),
        ),
      );
    },
    redirect: (context, state) {
      final loggedIn = appStateManager.isLoggedIn;
      final loggingIn = state.subloc == "/login";
      if (!loggedIn) return loggingIn ? null : '/login';
      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      final onboarding = state.subloc == "/onboarding";
      if (!isOnboardingComplete) return onboarding ? null : '/onboarding';
      if (loggingIn || onboarding) return "/${FooderlichTab.explore}";
      return null;
    },
  );
}
