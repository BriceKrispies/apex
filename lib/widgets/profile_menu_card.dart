import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileMenuItem {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.icon,
    this.iconColor,
    required this.title,
    this.titleColor,
    required this.onTap,
  });
}

class ProfileMenuCard extends StatelessWidget {
  final List<ProfileMenuItem> items;

  const ProfileMenuCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.greyBorder, width: 0.5),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon,
                    color: item.iconColor ?? Colors.black87, size: 22),
                title: Text(
                  item.title,
                  style: TextStyle(
                      fontSize: 15, color: item.titleColor ?? Colors.black87),
                ),
                trailing: Icon(Icons.chevron_right,
                    color: AppTheme.greyText, size: 22),
                onTap: item.onTap,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              ),
              if (index < items.length - 1)
                Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: AppTheme.greyBorder),
            ],
          );
        }),
      ),
    );
  }
}
