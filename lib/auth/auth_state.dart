import 'auth_user.dart';

/// Sealed auth state hierarchy.
///
/// The router and all auth-aware widgets switch on this type.
/// Adding a new state (e.g. AuthStateRequiresVerification) is a single-file change.
sealed class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateSignedOut extends AuthState {
  const AuthStateSignedOut();
}

/// The user is fully authenticated.
class AuthStateSignedIn extends AuthState {
  final AuthUser user;
  const AuthStateSignedIn(this.user);
}

/// A sign-in or session-restore attempt failed.
/// Treated as signed-out for routing purposes.
class AuthStateError extends AuthState {
  final String message;
  const AuthStateError(this.message);
}
