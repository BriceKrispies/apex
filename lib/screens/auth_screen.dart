import 'package:flutter/material.dart';
import '../app_config.dart';
import '../auth/auth_notifier.dart';
import '../auth/auth_state.dart';
import '../theme.dart';

/// Combined sign-in / sign-up screen.
///
/// Provider buttons call the mock auth service. When a real SDK is wired in,
/// only [AuthNotifier] and [MockAuthService] change — this screen stays the same.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  bool _isSignUp = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _toggleMode() {
    // Clear any lingering error when the user switches between sign-in/sign-up.
    authNotifier.clearError();
    setState(() => _isSignUp = !_isSignUp);
  }

  Future<void> _submitEmail() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSignUp) {
      await authNotifier.signUpWithEmail(
        _emailCtrl.text.trim(),
        _passwordCtrl.text,
        _nameCtrl.text.trim(),
      );
    } else {
      await authNotifier.signInWithEmail(
        _emailCtrl.text.trim(),
        _passwordCtrl.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: ValueListenableBuilder<AuthState>(
        valueListenable: authNotifier,
        builder: (context, state, _) {
          final isLoading = state is AuthStateLoading;
          final errorMessage =
              state is AuthStateError ? state.message : null;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildProviderButtons(isLoading),
                  const SizedBox(height: 24),
                  _buildDivider(),
                  const SizedBox(height: 24),
                  _buildEmailForm(isLoading),
                  const SizedBox(height: 16),
                  if (errorMessage != null) _buildErrorBanner(errorMessage),
                  const SizedBox(height: 16),
                  _buildSubmitButton(isLoading),
                  const SizedBox(height: 20),
                  _buildToggleLink(isLoading),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppTheme.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.handshake_outlined,
              color: Colors.white, size: 34),
        ),
        const SizedBox(height: 16),
        Text(
          AppConfig.appName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _isSignUp ? 'Create your account' : 'Sign in to continue',
          style: TextStyle(fontSize: 15, color: AppTheme.greyText),
        ),
      ],
    );
  }

  Widget _buildProviderButtons(bool isLoading) {
    return Column(
      children: [
        _ProviderButton(
          label: 'Continue with Google',
          brandLetter: 'G',
          brandColor: const Color(0xFF4285F4),
          onTap: isLoading ? null : authNotifier.signInWithGoogle,
        ),
        const SizedBox(height: 12),
        _ProviderButton(
          label: 'Continue with Facebook',
          brandLetter: 'f',
          brandColor: const Color(0xFF1877F2),
          onTap: isLoading ? null : authNotifier.signInWithFacebook,
        ),
        const SizedBox(height: 12),
        _ProviderButton(
          label: 'Continue with Apple',
          brandLetter: '',
          brandIcon: Icons.apple,
          brandColor: Colors.black,
          onTap: isLoading ? null : authNotifier.signInWithApple,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppTheme.greyBorder, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('or',
              style: TextStyle(color: AppTheme.greyText, fontSize: 13)),
        ),
        Expanded(child: Divider(color: AppTheme.greyBorder, thickness: 1)),
      ],
    );
  }

  Widget _buildEmailForm(bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (_isSignUp) ...[
            _FormField(
              controller: _nameCtrl,
              label: 'Full name',
              icon: Icons.person_outline,
              enabled: !isLoading,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
            ),
            const SizedBox(height: 12),
          ],
          _FormField(
            controller: _emailCtrl,
            label: 'Email address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            enabled: !isLoading,
            validator: (v) =>
                (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
          ),
          const SizedBox(height: 12),
          _FormField(
            controller: _passwordCtrl,
            label: 'Password',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            enabled: !isLoading,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppTheme.greyText,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (v) =>
                (v == null || v.length < 6) ? 'Password must be 6+ characters' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEF9A9A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFC62828), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFFC62828),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : _submitEmail,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.green,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.green.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                _isSignUp ? 'Create Account' : 'Sign In',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _buildToggleLink(bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isSignUp
              ? 'Already have an account? '
              : "Don't have an account? ",
          style: TextStyle(color: AppTheme.greyText, fontSize: 14),
        ),
        GestureDetector(
          onTap: isLoading ? null : _toggleMode,
          child: Text(
            _isSignUp ? 'Sign in' : 'Sign up',
            style: TextStyle(
              color: AppTheme.green,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Private widgets
// =============================================================================

class _ProviderButton extends StatelessWidget {
  final String label;
  final String brandLetter;
  final IconData? brandIcon;
  final Color brandColor;
  final VoidCallback? onTap;

  const _ProviderButton({
    required this.label,
    required this.brandLetter,
    this.brandIcon,
    required this.brandColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: AppTheme.greyBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          children: [
            _BrandMark(
              letter: brandLetter,
              icon: brandIcon,
              color: brandColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 32), // balance the brand mark width
          ],
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  final String letter;
  final IconData? icon;
  final Color color;

  const _BrandMark({required this.letter, this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: icon != null
          ? Icon(icon, size: 18, color: color)
          : Text(
              letter,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppTheme.greyText),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.greyBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.greyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.green, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF9A9A)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
