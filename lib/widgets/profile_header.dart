import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 38,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.person, size: 40, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (user.verified) ...[
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_box, size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          user.phone,
          style: TextStyle(fontSize: 14, color: AppTheme.greyText),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              '${user.rating}',
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              ' (${user.reviewCount} reviews)',
              style: TextStyle(fontSize: 14, color: AppTheme.greyText),
            ),
          ],
        ),
      ],
    );
  }
}
