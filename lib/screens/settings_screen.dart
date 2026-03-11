import 'package:flutter/material.dart';
import '../app_config.dart';
import '../auth/mock_auth_service.dart';
import '../theme.dart';

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
              const SizedBox(height: 32),
              _DevPanel(),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Developer mock auth scenario panel
// =============================================================================

class _DevPanel extends StatefulWidget {
  @override
  State<_DevPanel> createState() => _DevPanelState();
}

class _DevPanelState extends State<_DevPanel> {
  MockAuthScenario _selected = MockAuthService.scenario;

  static const _descriptions = {
    MockAuthScenario.defaultSuccess:
        'All sign-in methods succeed and return a full mock user.',
    MockAuthScenario.providerUnavailable:
        'Social provider buttons throw an unavailable error.',
    MockAuthScenario.loginFailure:
        'All sign-in attempts fail with a credentials error.',
    MockAuthScenario.expiredSession:
        'Session restore throws an expired-token error on next launch.',
    MockAuthScenario.firstTimeUser:
        'Sign-in succeeds but returns a blank first-time user profile.',
  };

  static const _labels = {
    MockAuthScenario.defaultSuccess: 'Default success',
    MockAuthScenario.providerUnavailable: 'Provider unavailable',
    MockAuthScenario.loginFailure: 'Login failure',
    MockAuthScenario.expiredSession: 'Expired session',
    MockAuthScenario.firstTimeUser: 'First-time user',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9C4),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFF9A825)),
              ),
              child: const Text(
                'DEV',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57F17)),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Mock Auth Scenario',
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Active scenario applies on the next sign-in attempt.',
          style: TextStyle(fontSize: 12, color: AppTheme.greyText),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.greyBorder, width: 0.5),
          ),
          child: Column(
            children: MockAuthScenario.values.map((scenario) {
              final isLast =
                  scenario == MockAuthScenario.values.last;
              return Column(
                children: [
                  RadioListTile<MockAuthScenario>(
                    value: scenario,
                    groupValue: _selected,
                    title: Text(
                      _labels[scenario]!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      _descriptions[scenario]!,
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.greyText),
                    ),
                    activeColor: AppTheme.green,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12),
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() => _selected = val);
                      MockAuthService.scenario = val;
                    },
                  ),
                  if (!isLast)
                    Divider(
                        height: 1,
                        indent: 12,
                        endIndent: 12,
                        color: AppTheme.greyBorder),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
