import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import 'auth_state.dart';
import 'auth_user.dart';
import 'mock_auth_service.dart';

/// Global auth notifier — single source of auth truth for the app.
///
/// The GoRouter listens to this via [refreshListenable] and re-evaluates its
/// redirect on every state change. Widgets use [ValueListenableBuilder] or
/// read [authNotifier.value] directly.
///
/// To swap in a real auth provider: replace [MockAuthService()] below with
/// your real [AuthService] implementation. Nothing else changes.
final AuthNotifier authNotifier = AuthNotifier(MockAuthService());

class AuthNotifier extends ValueNotifier<AuthState> {
  final AuthService _service;

  AuthNotifier(this._service) : super(const AuthStateLoading());

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  /// Call once at app startup. Attempts to restore a persisted session.
  /// The router's refreshListenable fires when this resolves, triggering
  /// any necessary redirects.
  Future<void> initialize() async {
    value = const AuthStateLoading();
    try {
      final user = await _service.restoreSession();
      value = user != null
          ? AuthStateSignedIn(user)
          : const AuthStateSignedOut();
    } catch (_) {
      // Expired session or restore failure → treat as signed out
      value = const AuthStateSignedOut();
    }
  }

  // ---------------------------------------------------------------------------
  // Sign-in
  // ---------------------------------------------------------------------------

  Future<void> signInWithGoogle() =>
      _run(() => _service.signInWithGoogle());

  Future<void> signInWithFacebook() =>
      _run(() => _service.signInWithFacebook());

  Future<void> signInWithApple() =>
      _run(() => _service.signInWithApple());

  Future<void> signInWithEmail(String email, String password) =>
      _run(() => _service.signInWithEmail(email, password));

  Future<void> signUpWithEmail(String email, String password, String name) =>
      _run(() => _service.signUpWithEmail(email, password, name));

  // ---------------------------------------------------------------------------
  // Sign-out
  // ---------------------------------------------------------------------------

  Future<void> signOut() async {
    value = const AuthStateLoading();
    try {
      await _service.signOut();
    } finally {
      value = const AuthStateSignedOut();
    }
  }

  // ---------------------------------------------------------------------------
  // Convenience accessors
  // ---------------------------------------------------------------------------

  bool get isSignedIn => value is AuthStateSignedIn;

  /// Clears an error state back to signed-out without re-running session restore.
  void clearError() {
    if (value is AuthStateError) value = const AuthStateSignedOut();
  }

  AuthUser? get currentUser {
    final s = value;
    return s is AuthStateSignedIn ? s.user : null;
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  Future<void> _run(Future<AuthUser> Function() fn) async {
    value = const AuthStateLoading();
    try {
      final user = await fn();
      value = AuthStateSignedIn(user);
    } catch (e) {
      value = AuthStateError(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
