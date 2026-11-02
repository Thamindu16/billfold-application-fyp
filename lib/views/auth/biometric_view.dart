import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../../core/utils/page_transitions.dart';
import 'privacy_policy_view.dart';

enum _BioStatus { checking, available, unavailable }

class BiometricView extends StatefulWidget {
  const BiometricView({super.key});

  @override
  State<BiometricView> createState() => _BiometricViewState();
}

class _BiometricViewState extends State<BiometricView> {
  final LocalAuthentication auth = LocalAuthentication();

  _BioStatus _status = _BioStatus.checking;
  List<BiometricType> _types = [];
  bool _isAuthenticating = false;
  bool _success = false;
  String? _message;
  bool _messageIsError = true;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  // ---------- Device check ----------

  Future<void> _checkBiometrics() async {
    try {
      final supported = await auth.isDeviceSupported();
      final canCheck = await auth.canCheckBiometrics;
      final types = await auth.getAvailableBiometrics();

      if (!mounted) return;
      setState(() {
        _types = types;
        _status = (supported && canCheck && types.isNotEmpty)
            ? _BioStatus.available
            : _BioStatus.unavailable;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _status = _BioStatus.unavailable);
    }
  }

  bool get _hasFace => _types.contains(BiometricType.face);
  bool get _hasFingerprint =>
      _types.contains(BiometricType.fingerprint) ||
      _types.contains(BiometricType.strong) ||
      _types.contains(BiometricType.weak);

  IconData get _icon {
    if (_hasFace && !_hasFingerprint) return Icons.face_rounded;
    return Icons.fingerprint_rounded;
  }

  String get _methodName {
    if (_hasFace && _hasFingerprint) return 'Fingerprint or Face ID';
    if (_hasFace) return 'Face ID';
    return 'Fingerprint';
  }

  // ---------- Actions ----------

  void _navigateToPrivacyPolicy() {
    Navigator.push(context, SlideFadeRoute(page: const PrivacyPolicyView()));
  }

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
      _message = null;
    });

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Authenticate to enable biometric login for BILLFOLD',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (!mounted) return;

      if (didAuthenticate) {
        // TODO: Save "biometric enabled = true" (shared_preferences / secure storage)
        setState(() {
          _isAuthenticating = false;
          _success = true;
        });
        await Future.delayed(const Duration(milliseconds: 900));
        if (mounted) _navigateToPrivacyPolicy();
      } else {
        // User cancelled or failed to match: no scary error, just a hint
        setState(() {
          _isAuthenticating = false;
          _messageIsError = true;
          _message = 'Authentication was not completed. Please try again.';
        });
      }
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        _isAuthenticating = false;
        _messageIsError = true;
        _message = _errorText(e.code);
      });
      if (e.code == 'NotEnrolled' || e.code == 'NotAvailable') {
        _checkBiometrics();
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isAuthenticating = false;
        _messageIsError = true;
        _message = 'Something went wrong. Please try again.';
      });
    }
  }

  String _errorText(String code) {
    switch (code) {
      case 'NotEnrolled':
        return 'No fingerprint or face is set up on this phone. Add one in your phone settings.';
      case 'NotAvailable':
        return 'Biometric authentication is not available on this device.';
      case 'PasscodeNotSet':
        return 'Please set a screen lock (PIN / pattern) in your phone settings first.';
      case 'LockedOut':
        return 'Too many attempts. Please wait a moment and try again.';
      case 'PermanentlyLockedOut':
        return 'Biometrics are locked. Unlock your phone with your PIN / pattern first, then try again.';
      default:
        return 'Biometric authentication failed. Please try again.';
    }
  }

  void _skipBiometric() {
    if (_isAuthenticating || _success) return;
    _navigateToPrivacyPolicy();
  }

  // ---------- UI helpers ----------

  Widget _buildBenefit(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF3B82F6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Color(0xFFCBD5E1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBox(String text, {required bool isError}) {
    final color = isError ? Colors.redAccent : const Color(0xFF3B82F6);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isError ? Icons.error_outline_rounded : Icons.info_outline_rounded,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final unavailable = _status == _BioStatus.unavailable;

    String title;
    String subtitle;
    if (_status == _BioStatus.checking) {
      title = 'Biometric Security';
      subtitle = 'Checking your device...';
    } else if (unavailable) {
      title = 'Biometrics unavailable';
      subtitle =
          "We couldn't find a fingerprint or face set up on this phone. You can still use BILLFOLD and enable this later.";
    } else {
      title = 'Enable $_methodName';
      subtitle =
          'Unlock BILLFOLD quickly and securely, and keep your financial data even more protected.';
    }

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: _success
                  ? const [Color(0xFF10B981), Color(0xFF059669)]
                  : unavailable
                  ? const [Color(0xFF475569), Color(0xFF334155)]
                  : const [Color(0xFF3B82F6), Color(0xFF6366F1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    (_success
                            ? const Color(0xFF10B981)
                            : const Color(0xFF3B82F6))
                        .withOpacity(unavailable ? 0.0 : 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              _success
                  ? Icons.check_rounded
                  : unavailable
                  ? Icons.no_encryption_gmailerrorred_rounded
                  : _icon,
              key: ValueKey('$_success$unavailable$_icon'),
              size: 48,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _success ? 'All set!' : title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _success ? 'Biometric login is now enabled.' : subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    final unavailable = _status == _BioStatus.unavailable;
    final checking = _status == _BioStatus.checking;

    return Column(
      children: [
        if (_message != null) ...[
          _buildMessageBox(_message!, isError: _messageIsError),
          const SizedBox(height: 16),
        ],
        if (!unavailable)
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: (_isAuthenticating || checking || _success)
                  ? null
                  : _authenticate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: (_isAuthenticating || checking)
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      _success
                          ? 'Enabled'
                          : _message != null
                          ? 'Try again'
                          : 'Enable $_methodName',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: (_isAuthenticating || _success) ? null : _skipBiometric,
          child: Text(
            unavailable ? 'Continue without biometrics' : 'Skip for now',
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          ),
        ),
        if (!unavailable)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'You can change this anytime in Settings.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1120), Color(0xFF151D2A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildHeader(),
                        if (_status == _BioStatus.available && !_success) ...[
                          const SizedBox(height: 32),
                          _buildBenefit(
                            Icons.bolt_rounded,
                            'Sign in faster, no typing needed',
                          ),
                          _buildBenefit(
                            Icons.lock_outline_rounded,
                            'Your biometrics never leave your device',
                          ),
                          _buildBenefit(
                            Icons.shield_outlined,
                            'Extra protection for your financial data',
                          ),
                        ],
                        if (_status == _BioStatus.unavailable) ...[
                          const SizedBox(height: 24),
                          _buildMessageBox(
                            'Set up a fingerprint or face in your phone Settings, then come back and enable it from the app settings.',
                            isError: false,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
