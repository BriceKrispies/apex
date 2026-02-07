import 'package:flutter/material.dart';
import '../models/category_tile.dart';
import '../models/job_card.dart';
import '../models/user_profile.dart';

class MockRepo {
  MockRepo._();

  static const List<CategoryTile> categories = [
    CategoryTile(
      id: '1',
      label: 'Trucker',
      icon: Icons.local_shipping_outlined,
      type: CategoryType.trucker,
    ),
    CategoryTile(
      id: '2',
      label: 'Mason',
      icon: Icons.build_outlined,
    ),
    CategoryTile(
      id: '3',
      label: 'Electrician',
      icon: Icons.electrical_services_outlined,
    ),
    CategoryTile(
      id: '4',
      label: 'Plumber',
      icon: Icons.plumbing_outlined,
    ),
    CategoryTile(
      id: '5',
      label: 'Carpenter',
      icon: Icons.carpenter_outlined,
    ),
  ];

  static const List<JobCard> jobs = [
    JobCard(
      id: '1',
      title: 'Diagnose noise in minibus engine',
      categoryLabel: 'Mechanic',
      description:
          'Minibus making grinding noise from front; need diagnosis and estimate for repair.',
      location: 'Georgetown,',
      date: '2/05/26',
      priceGyd: 50000,
    ),
    JobCard(
      id: '2',
      title: 'Fix doors, shelves and cabinet',
      categoryLabel: 'Carpenter',
      description:
          'Need carpenter to repair kitchen cabinet doors and install new shelves.',
      location: 'Linden,',
      date: '2/06/26',
      priceGyd: 55000,
    ),
    JobCard(
      id: '3',
      title: 'Rewire living room outlets',
      categoryLabel: 'Electrician',
      description:
          'Several outlets not working. Need full rewiring for the living room.',
      location: 'New Amsterdam,',
      date: '2/07/26',
      priceGyd: 40000,
    ),
  ];

  static const UserProfile currentUser = UserProfile(
    name: 'Marisol Rivera',
    phone: '+592-600-1023',
    rating: 4.8,
    reviewCount: 23,
    verified: true,
    jobsCompleted: 0,
    memberSince: '2/03/26',
    walletBalance: 15240.75,
    subscriptionActive: true,
    subscriptionExpires: '2/10/26',
  );
}
