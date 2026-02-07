class UserProfile {
  final String name;
  final String phone;
  final double rating;
  final int reviewCount;
  final bool verified;
  final int jobsCompleted;
  final String memberSince;
  final double walletBalance;
  final bool subscriptionActive;
  final String subscriptionExpires;

  const UserProfile({
    required this.name,
    required this.phone,
    required this.rating,
    required this.reviewCount,
    required this.verified,
    required this.jobsCompleted,
    required this.memberSince,
    required this.walletBalance,
    required this.subscriptionActive,
    required this.subscriptionExpires,
  });
}
