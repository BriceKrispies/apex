import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_repo.dart';
import '../theme.dart';
import '../widgets/category_scroller.dart';
import '../widgets/job_card_widget.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search affordance
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.greyBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppTheme.greyText),
                  const SizedBox(width: 10),
                  Text(
                    'Search jobs...',
                    style: TextStyle(color: AppTheme.greyText, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CategoryScroller(
              categories: MockRepo.categories,
              tileHeight: 90,
            ),
            const SizedBox(height: 16),
            ...MockRepo.jobs.map(
              (job) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: JobCardWidget(
                  job: job,
                  onTap: () => context.push('/jobs/${job.id}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
