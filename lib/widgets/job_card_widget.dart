import 'package:flutter/material.dart';
import '../app_config.dart';
import '../models/job_card.dart';
import '../theme.dart';

class JobCardWidget extends StatelessWidget {
  final JobCard job;
  final VoidCallback? onTap;

  const JobCardWidget({super.key, required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.greyBorder, width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.sell_outlined,
                          size: 14, color: AppTheme.greyText),
                      const SizedBox(width: 4),
                      Text(
                        job.categoryLabel,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.greyText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    job.description,
                    style: TextStyle(fontSize: 13, color: AppTheme.greyText),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 14, color: AppTheme.greyText),
                      const SizedBox(width: 4),
                      Text(
                        job.location,
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.greyText),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.calendar_today_outlined,
                          size: 14, color: AppTheme.greyText),
                      const SizedBox(width: 4),
                      Text(
                        job.date,
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.greyText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.greenLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${AppConfig.currencyPrefix} \$${job.priceGyd}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
