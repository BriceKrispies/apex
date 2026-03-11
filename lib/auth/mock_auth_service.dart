import 'auth_service.dart';
import 'auth_user.dart';

// =============================================================================
// Dev knobs — change these in code to exercise different auth scenarios
// =============================================================================

/// Active mock scenario. Change this value to test different auth flows.
///
/// - [MockAuthScenario.defaultSuccess]   — everything works, returns full user
/// - [MockAuthScenario.providerUnavailable] — social buttons throw an error
/// - [MockAuthScenario.loginFailure]     — all sign-in attempts fail
/// - [MockAuthScenario.expiredSession]   — session restore throws expired error
/// - [MockAuthScenario.firstTimeUser]    — sign-in succeeds with a blank profile
enum MockAuthScenario {
  defaultSuccess,
  providerUnavailable,
  loginFailure,
  expiredSession,
  firstTimeUser,
}

class MockAuthService implements AuthService {
  /// Change this to switch the active mock scenario.
  static MockAuthScenario scenario = MockAuthScenario.defaultSuccess;

  /// Simulated network round-trip delay.
  static const Duration _delay = Duration(milliseconds: 900);

  /// In-memory persisted session — simulates a stored token in development.
  /// Survives hot-restart only (as expected for a dev-only mock).
  static AuthUser? _persistedSession;

  // ---------------------------------------------------------------------------
  // Fake user fixtures
  // ---------------------------------------------------------------------------

  static AuthUser _defaultUser(AuthProvider via) => AuthUser(
        id: 'mock-uid-001',
        name: 'Marisol Rivera',
        email: 'marisol@example.com',
        phone: '+592-600-1023',
        verified: true,
        rating: 4.8,
        reviewCount: 23,
        jobsCompleted: 0,
        memberSince: '2/03/26',
        walletBalance: 15240.75,
        subscriptionActive: true,
        subscriptionExpires: '2/10/26',
        provider: via,
      );

  static AuthUser _firstTimeUser(AuthProvider via) => AuthUser(
        id: 'mock-uid-002',
        name: 'New User',
        email: 'newuser@example.com',
        phone: null,
        verified: false,
        rating: 0.0,
        reviewCount: 0,
        jobsCompleted: 0,
        memberSince: '3/11/26',
        walletBalance: 0,
        subscriptionActive: false,
        subscriptionExpires: '',
        provider: via,
      );

  // ---------------------------------------------------------------------------
  // AuthService implementation
  // ---------------------------------------------------------------------------

  @override
  Future<AuthUser?> restoreSession() async {
    await Future.delayed(_delay);
    if (scenario == MockAuthScenario.expiredSession) {
      _persistedSession = null;
      throw Exception('Your session has expired. Please sign in again.');
    }
    return _persistedSession;
  }

  @override
  Future<AuthUser?> getCurrentUser() async => _persistedSession;

  @override
  Future<AuthUser> signInWithGoogle() => _socialSignIn(AuthProvider.google);

  @override
  Future<AuthUser> signInWithFacebook() =>
      _socialSignIn(AuthProvider.facebook);

  @override
  Future<AuthUser> signInWithApple() => _socialSignIn(AuthProvider.apple);

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    await Future.delayed(_delay);
    _assertNotFailing(AuthProvider.email);
    final user = scenario == MockAuthScenario.firstTimeUser
        ? _firstTimeUser(AuthProvider.email)
        : _defaultUser(AuthProvider.email);
    return _persist(user);
  }

  @override
  Future<AuthUser> signUpWithEmail(
      String email, String password, String name) async {
    await Future.delayed(_delay);
    if (scenario == MockAuthScenario.loginFailure) {
      throw Exception('Could not create account. That email may already be in use.');
    }
    final user = AuthUser(
      id: 'mock-uid-new',
      name: name.trim().isNotEmpty ? name.trim() : 'New User',
      email: email,
      phone: null,
      verified: false,
      rating: 0.0,
      reviewCount: 0,
      jobsCompleted: 0,
      memberSince: '3/11/26',
      walletBalance: 0,
      subscriptionActive: false,
      subscriptionExpires: '',
      provider: AuthProvider.email,
    );
    return _persist(user);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _persistedSession = null;
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<AuthUser> _socialSignIn(AuthProvider via) async {
    await Future.delayed(_delay);
    _assertNotFailing(via);
    final user = scenario == MockAuthScenario.firstTimeUser
        ? _firstTimeUser(via)
        : _defaultUser(via);
    return _persist(user);
  }

  /// Throws based on active scenario, otherwise does nothing.
  void _assertNotFailing(AuthProvider via) {
    switch (scenario) {
      case MockAuthScenario.providerUnavailable:
        final name = via.name[0].toUpperCase() + via.name.substring(1);
        throw Exception('$name sign-in is not available right now.');
      case MockAuthScenario.loginFailure:
        throw Exception('Sign-in failed. Check your credentials and try again.');
      default:
        break;
    }
  }

  AuthUser _persist(AuthUser user) {
    _persistedSession = user;
    return user;
  }
}
