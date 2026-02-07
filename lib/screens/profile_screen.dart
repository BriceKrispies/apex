import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_repo.dart';
import '../screens/settings_screen.dart';
import '../widgets/profile_header.dart';
import '../widgets/wallet_card.dart';
import '../widgets/stats_tiles_row.dart';
import '../widgets/profile_menu_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockRepo.currentUser;
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
      body: ValueListenableBuilder<bool>(
        valueListenable: showWalletNotifier,
        builder: (context, showWallet, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      onTap: () => context.push('/profile/subscription'),
                    ),
                    ProfileMenuItem(
                      icon: Icons.receipt_long_outlined,
                      title: 'Transaction History',
                      onTap: () => context.push('/profile/transactions'),
                    ),
                    ProfileMenuItem(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      onTap: () => context.push('/profile/terms'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
