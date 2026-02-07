import 'package:flutter/material.dart';
import '../theme.dart';

class PrimaryTopButtons extends StatelessWidget {
  final VoidCallback onPostJob;
  final VoidCallback onHirePro;
  final VoidCallback onHireTrucker;

  const PrimaryTopButtons({
    super.key,
    required this.onPostJob,
    required this.onHirePro,
    required this.onHireTrucker,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PillButton(label: 'Post a Job', onTap: onPostJob),
        const SizedBox(width: 10),
        _PillButton(label: 'Hire a Pro', onTap: onHirePro),
        const SizedBox(width: 10),
        _PillButton(label: 'Hire a Trucker', onTap: onHireTrucker),
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PillButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppTheme.greyBorder),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
