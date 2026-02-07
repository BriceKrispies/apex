import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme.dart';

class StatsTilesRow extends StatelessWidget {
  final UserProfile user;

  const StatsTilesRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            value: '${user.jobsCompleted}',
            label: 'Jobs Completed',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            value: user.memberSince,
            label: 'Member Since',
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String value;
  final String label;

  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.greyBorder, width: 0.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: AppTheme.greyText),
          ),
        ],
      ),
    );
  }
}
