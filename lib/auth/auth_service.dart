import 'auth_user.dart';

/// Auth service abstraction.
///
/// Drop in a real implementation (Supabase, Firebase, custom JWT) behind this
/// interface without touching any screen or widget code.
///
/// All methods throw on failure so callers can catch and display error messages.
abstract class AuthService {
  /// Attempt to restore a previously persisted session.
  /// Returns the user if a valid session exists, null if not.
  Future<AuthUser?> restoreSession();

  /// Returns the currently signed-in user, or null if none.
  Future<AuthUser?> getCurrentUser();

  Future<AuthUser> signInWithGoogle();
  Future<AuthUser> signInWithFacebook();

  /// Apple sign-in is available on iOS/macOS; check platform before calling.
  Future<AuthUser> signInWithApple();

  Future<AuthUser> signInWithEmail(String email, String password);
  Future<AuthUser> signUpWithEmail(String email, String password, String name);

  Future<void> signOut();
}
