import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_repo.dart';
import '../theme.dart';
import '../widgets/primary_top_buttons.dart';
import '../widgets/section_header.dart';
import '../widgets/category_scroller.dart';
import '../widgets/job_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryTopButtons(
              onPostJob: () => context.push('/jobs/post'),
              onHirePro: () => context.push('/providers/hire'),
              onHireTrucker: () => context.push('/truckers/hire'),
            ),
            const SizedBox(height: 20),
            // Become a Provider promo card
            InkWell(
              onTap: () => context.push('/provider/onboarding'),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.greyBorder, width: 0.5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.greenLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.handshake_outlined,
                          color: AppTheme.green, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Become a Provider',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Sign up to offer your services and earn',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: AppTheme.greyText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Popular Services', onSeeAll: () {}),
            const SizedBox(height: 12),
            CategoryScroller(categories: MockRepo.categories),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Recent Jobs Near You'),
            const SizedBox(height: 12),
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
