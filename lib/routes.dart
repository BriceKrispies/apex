import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth/auth_notifier.dart';
import 'auth/auth_state.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/jobs_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/job_detail_screen.dart';
import 'screens/shell_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// Routes that require an authenticated user.
// Public routes (/home, /jobs, /jobs/:id, /auth) are NOT in this list.
const _protectedPrefixes = [
  '/profile',
  '/messages',
  '/jobs/post',
  '/providers/hire',
  '/truckers/hire',
  '/provider/onboarding',
];

bool _isProtected(String location) =>
    _protectedPrefixes.any((p) => location.startsWith(p));

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',

  // The router re-evaluates its redirect whenever authNotifier fires.
  refreshListenable: authNotifier,

  redirect: (context, state) {
    final loc = state.matchedLocation;
    final authState = authNotifier.value;
    final isOnAuth = loc == '/auth';

    // Don't redirect while the initial session restore is in progress.
    if (authState is AuthStateLoading) return null;

    final isSignedIn = authState is AuthStateSignedIn;

    // Signed-out user trying to reach a protected route → send to auth.
    if (!isSignedIn && _isProtected(loc) && !isOnAuth) return '/auth';

    // Already signed-in user landing on the auth screen → send home.
    if (isSignedIn && isOnAuth) return '/home';

    return null;
  },

  routes: [
    // Auth screen — outside the shell so it has no bottom nav.
    GoRoute(
      path: '/auth',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AuthScreen(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/jobs',
              builder: (context, state) => const JobsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/messages',
              builder: (context, state) => const MessagesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/profile/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/jobs/post',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Post a Job'),
    ),
    GoRoute(
      path: '/providers/hire',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Hire a Pro'),
    ),
    GoRoute(
      path: '/truckers/hire',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Hire a Trucker'),
    ),
    GoRoute(
      path: '/provider/onboarding',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Become a Provider'),
    ),
    GoRoute(
      path: '/jobs/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          JobDetailScreen(jobId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/profile/my-jobs',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'My Jobs'),
    ),
    GoRoute(
      path: '/profile/subscription',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Subscription'),
    ),
    GoRoute(
      path: '/profile/transactions',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Transaction History'),
    ),
    GoRoute(
      path: '/profile/terms',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Terms & Conditions'),
    ),
  ],
);
