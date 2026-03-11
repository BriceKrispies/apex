import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_notifier.dart';
import '../auth/auth_state.dart';
import '../auth/auth_user.dart';
import '../models/user_profile.dart';
import '../screens/settings_screen.dart';
import '../widgets/profile_header.dart';
import '../widgets/wallet_card.dart';
import '../widgets/stats_tiles_row.dart';
import '../widgets/profile_menu_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// Bridge: convert the internal [AuthUser] to the [UserProfile] shape that
  /// the existing profile widgets expect.
  ///
  /// When a real backend is added, the profile fields (wallet, stats, etc.)
  /// will come from a database query keyed on [user.id]; for now the mock
  /// AuthUser carries that data directly.
  static UserProfile _toUserProfile(AuthUser user) => UserProfile(
        name: user.name,
        phone: user.phone ?? '',
        rating: user.rating,
        reviewCount: user.reviewCount,
        verified: user.verified,
        jobsCompleted: user.jobsCompleted,
        memberSince: user.memberSince,
        walletBalance: user.walletBalance,
        subscriptionActive: user.subscriptionActive,
        subscriptionExpires: user.subscriptionExpires,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: ValueListenableBuilder<AuthState>(
        valueListenable: authNotifier,
        builder: (context, authState, _) {
          // The router guarantees we only reach this screen when signed in,
          // but guard defensively so the widget tree never crashes on a race.
          if (authState is! AuthStateSignedIn) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = _toUserProfile(authState.user);

          return ValueListenableBuilder<bool>(
            valueListenable: showWalletNotifier,
            builder: (context, showWallet, _) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    ProfileHeader(user: user),
                    const SizedBox(height: 20),
                    if (showWallet) ...[
                      WalletCard(user: user),
                      const SizedBox(height: 16),
                    ],
                    StatsTilesRow(user: user),
                    const SizedBox(height: 16),
                    ProfileMenuCard(
                      items: [
                        ProfileMenuItem(
                          icon: Icons.work_outline,
                          title: 'My Jobs',
                          onTap: () => context.push('/profile/my-jobs'),
                        ),
                        ProfileMenuItem(
                          icon: Icons.workspace_premium,
                          iconColor: Colors.amber,
                          title: 'Subscription',
                          onTap: () =>
                              context.push('/profile/subscription'),
                        ),
                        ProfileMenuItem(
                          icon: Icons.receipt_long_outlined,
                          title: 'Transaction History',
                          onTap: () =>
                              context.push('/profile/transactions'),
                        ),
                        ProfileMenuItem(
                          icon: Icons.description_outlined,
                          title: 'Terms & Conditions',
                          onTap: () => context.push('/profile/terms'),
                        ),
                        ProfileMenuItem(
                          icon: Icons.logout,
                          iconColor: Colors.redAccent,
                          title: 'Sign Out',
                          titleColor: Colors.redAccent,
                          onTap: () => authNotifier.signOut(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
