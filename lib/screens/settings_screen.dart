import 'package:flutter/material.dart';
import '../app_config.dart';

/// Global notifier for wallet visibility toggle.
final ValueNotifier<bool> showWalletNotifier = ValueNotifier<bool>(true);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ValueListenableBuilder<bool>(
        valueListenable: showWalletNotifier,
        builder: (context, showWallet, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                AppConfig.appName,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Show Wallet Card'),
                subtitle:
                    const Text('Toggle wallet section on profile screen'),
                value: showWallet,
                onChanged: (val) => showWalletNotifier.value = val,
              ),
            ],
          );
        },
      ),
    );
  }
}
