import 'package:flutter/material.dart';
import '../../core/utils/page_transitions.dart';
import 'otp_view.dart';

class Country {
  final String name;
  final String flag;
  final String dialCode; // without '+'
  final RegExp pattern; // national number (without leading 0)
  final String example;

  const Country({
    required this.name,
    required this.flag,
    required this.dialCode,
    required this.pattern,
    required this.example,
  });
}

final List<Country> kCountries = [
  Country(
    name: 'Sri Lanka',
    flag: '🇱🇰',
    dialCode: '94',
    pattern: RegExp(r'^7\d{8}$'),
    example: '77 123 4567',
  ),
  Country(
    name: 'India',
    flag: '🇮🇳',
    dialCode: '91',
    pattern: RegExp(r'^[6-9]\d{9}$'),
    example: '98765 43210',
  ),
  Country(
    name: 'Maldives',
    flag: '🇲🇻',
    dialCode: '960',
    pattern: RegExp(r'^[79]\d{6}$'),
    example: '771 2345',
  ),
  Country(
    name: 'Pakistan',
    flag: '🇵🇰',
    dialCode: '92',
    pattern: RegExp(r'^3\d{9}$'),
    example: '301 2345678',
  ),
  Country(
    name: 'Bangladesh',
    flag: '🇧🇩',
    dialCode: '880',
    pattern: RegExp(r'^1[3-9]\d{8}$'),
    example: '1712 345678',
  ),
  Country(
    name: 'United States / Canada',
    flag: '🇺🇸',
    dialCode: '1',
    pattern: RegExp(r'^[2-9]\d{2}[2-9]\d{6}$'),
    example: '202 555 0123',
  ),
  Country(
    name: 'United Kingdom',
    flag: '🇬🇧',
    dialCode: '44',
    pattern: RegExp(r'^7\d{9}$'),
    example: '7400 123456',
  ),
  Country(
    name: 'Australia',
    flag: '🇦🇺',
    dialCode: '61',
    pattern: RegExp(r'^4\d{8}$'),
    example: '412 345 678',
  ),
  Country(
    name: 'United Arab Emirates',
    flag: '🇦🇪',
    dialCode: '971',
    pattern: RegExp(r'^5\d{8}$'),
    example: '50 123 4567',
  ),
  Country(
    name: 'Saudi Arabia',
    flag: '🇸🇦',
    dialCode: '966',
    pattern: RegExp(r'^5\d{8}$'),
    example: '51 234 5678',
  ),
  Country(
    name: 'Qatar',
    flag: '🇶🇦',
    dialCode: '974',
    pattern: RegExp(r'^[3567]\d{7}$'),
    example: '3312 3456',
  ),
  Country(
    name: 'Kuwait',
    flag: '🇰🇼',
    dialCode: '965',
    pattern: RegExp(r'^[569]\d{7}$'),
    example: '5012 3456',
  ),
  Country(
    name: 'Singapore',
    flag: '🇸🇬',
    dialCode: '65',
    pattern: RegExp(r'^[89]\d{7}$'),
    example: '8123 4567',
  ),
  Country(
    name: 'Malaysia',
    flag: '🇲🇾',
    dialCode: '60',
    pattern: RegExp(r'^1\d{8,9}$'),
    example: '12 345 6789',
  ),
  Country(
    name: 'Germany',
    flag: '🇩🇪',
    dialCode: '49',
    pattern: RegExp(r'^1\d{9,10}$'),
    example: '1512 3456789',
  ),
  Country(
    name: 'Japan',
    flag: '🇯🇵',
    dialCode: '81',
    pattern: RegExp(r'^[7-9]0\d{8}$'),
    example: '90 1234 5678',
  ),
];

class OtpRequestView extends StatefulWidget {
  const OtpRequestView({super.key});

  @override
  State<OtpRequestView> createState() => _OtpRequestViewState();
}

class _OtpRequestViewState extends State<OtpRequestView> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  late Country _selectedCountry = kCountries.first; // Sri Lanka by default

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, SlideFadeRoute(page: const OtpView()));
    }
  }

  /// Returns the national number (no country code, no leading 0),
  /// or null if the number does not belong to the selected country.
  String? _nationalNumber(String input) {
    final dial = _selectedCountry.dialCode;
    final digits = input.replaceAll(RegExp(r'\D'), '');

    if (input.startsWith('+')) {
      return digits.startsWith(dial) ? digits.substring(dial.length) : null;
    }
    if (digits.startsWith('00')) {
      final withoutPrefix = digits.substring(2);
      return withoutPrefix.startsWith(dial)
          ? withoutPrefix.substring(dial.length)
          : null;
    }
    if (digits.startsWith('0')) {
      return digits.substring(1);
    }
    return digits;
  }

  String? _validateContact(String? value) {
    final input = value?.trim() ?? '';

    if (input.isEmpty) {
      return 'Please enter email or phone number';
    }

    // Email
    if (input.contains('@') || RegExp(r'[A-Za-z]').hasMatch(input)) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
        return 'Please enter a valid email address';
      }
      return null;
    }

    // Phone
    if (!RegExp(r'^\+?[\d\s\-()]+$').hasMatch(input)) {
      return 'Phone number contains invalid characters';
    }

    final national = _nationalNumber(input);
    if (national == null) {
      return 'Number does not match the selected country (+${_selectedCountry.dialCode})';
    }
    if (!_selectedCountry.pattern.hasMatch(national)) {
      return 'Enter a valid ${_selectedCountry.name} mobile number\n(e.g. ${_selectedCountry.example})';
    }
    return null;
  }

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  Widget _buildCountryPicker() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Country>(
          value: _selectedCountry,
          dropdownColor: const Color(0xFF1E293B),
          iconEnabledColor: const Color(0xFF64748B),
          borderRadius: BorderRadius.circular(14),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          selectedItemBuilder: (context) {
            return kCountries.map((c) {
              return Center(
                child: Text(
                  '${c.flag} +${c.dialCode}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              );
            }).toList();
          },
          items: kCountries.map((c) {
            return DropdownMenuItem<Country>(
              value: c,
              child: Text(
                '${c.flag}  ${c.name} (+${c.dialCode})',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (country) {
            if (country == null) return;
            setState(() => _selectedCountry = country);
            // Re-validate with the new country if user already typed something
            if (_contactController.text.isNotEmpty) {
              _formKey.currentState?.validate();
            }
          },
        ),
      ),
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withOpacity(0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mark_email_read_rounded,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'OTP verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Enter your email or phone number and we'll\nsend you a one-time code.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 36),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email or phone number',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCountryPicker(),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _contactController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            validator: _validateContact,
                            decoration: InputDecoration(
                              hintText:
                                  'name@email.com or ${_selectedCountry.example}',
                              hintStyle: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 14,
                              ),
                              errorMaxLines: 3,
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: Color(0xFF64748B),
                                size: 20,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1E293B),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF334155),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3B82F6),
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
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
                        onPressed: _handleSendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
