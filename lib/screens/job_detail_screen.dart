import 'package:flutter/material.dart';
import '../app_config.dart';
import '../data/mock_repo.dart';
import '../theme.dart';

class JobDetailScreen extends StatelessWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final job = MockRepo.jobs.firstWhere(
      (j) => j.id == jobId,
      orElse: () => MockRepo.jobs.first,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.greenLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${AppConfig.currencyPrefix} \$${job.priceGyd}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.green,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.sell_outlined,
                    size: 16, color: AppTheme.greyText),
                const SizedBox(width: 6),
                Text(
                  job.categoryLabel,
                  style: TextStyle(fontSize: 14, color: AppTheme.greyText),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              job.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 16, color: AppTheme.greyText),
                const SizedBox(width: 6),
                Text(job.location,
                    style: TextStyle(color: AppTheme.greyText)),
                const SizedBox(width: 20),
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: AppTheme.greyText),
                const SizedBox(width: 6),
                Text(job.date,
                    style: TextStyle(color: AppTheme.greyText)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
