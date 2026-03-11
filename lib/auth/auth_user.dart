/// Internal app user model.
///
/// The rest of the app depends on this type only — never on provider-specific
/// user objects (Google, Supabase, Firebase, etc.). When a real auth provider
/// is wired in, its user object is mapped here at the auth service layer and
/// never leaks further.
enum AuthProvider { email, google, facebook, apple, mock }

class AuthUser {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final bool verified;
  final double rating;
  final int reviewCount;
  final int jobsCompleted;
  final String memberSince;
  final double walletBalance;
  final bool subscriptionActive;
  final String subscriptionExpires;
  final AuthProvider provider;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.verified = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.jobsCompleted = 0,
    this.memberSince = '',
    this.walletBalance = 0,
    this.subscriptionActive = false,
    this.subscriptionExpires = '',
    required this.provider,
  });
}
