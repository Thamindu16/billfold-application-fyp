import 'package:flutter/material.dart';
import 'privacy_security/privacy_security_view.dart';
import 'notifications_view.dart';
import 'language_view.dart';
import 'currency_view.dart';
import 'about_view.dart';
import '../profile/profile_view.dart';

class SettingsView extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const SettingsView({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late bool _isDark = widget.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDark ? const Color(0xFF0B1120) : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: _isDark ? Colors.white70 : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: _isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: TextStyle(
                color: _isDark ? const Color(0xFF94A3B8) : Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: _isDark ? const Color(0xFF131B2E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isDark
                      ? const Color(0xFF1E293B)
                      : Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  _buildTile(
                    Icons.person_outline,
                    'My profile',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileView(),
                      ),
                    ),
                    _isDark,
                  ),
                  Divider(
                    height: 1,
                    color: _isDark
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  _buildTile(
                    Icons.lock_outline,
                    'Privacy & security',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PrivacySecurityView(isDarkMode: _isDark),
                      ),
                    ),
                    _isDark,
                  ),
                  Divider(
                    height: 1,
                    color: _isDark
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  _buildTile(
                    Icons.notifications_none,
                    'Notifications',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NotificationsView(isDarkMode: _isDark),
                      ),
                    ),
                    _isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'General',
              style: TextStyle(
                color: _isDark ? const Color(0xFF94A3B8) : Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: _isDark ? const Color(0xFF131B2E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isDark
                      ? const Color(0xFF1E293B)
                      : Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  _buildSubTile(
                    Icons.language,
                    'Language',
                    'English',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageView(isDarkMode: _isDark),
                      ),
                    ),
                    _isDark,
                  ),
                  Divider(
                    height: 1,
                    color: _isDark
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  _buildSubTile(
                    Icons.currency_exchange,
                    'Currency',
                    'LKR',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyView(isDarkMode: _isDark),
                      ),
                    ),
                    _isDark,
                  ),
                  Divider(
                    height: 1,
                    color: _isDark
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  _buildSubTile(
                    Icons.access_time_outlined,
                    'About / app version',
                    '1.0.0',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutView(isDarkMode: _isDark),
                      ),
                    ),
                    _isDark,
                  ),
                  Divider(
                    height: 1,
                    color: _isDark
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  SwitchListTile(
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _isDark
                            ? const Color(0xFF1E293B)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.wb_sunny_outlined,
                        color: Color(0xFF3B82F6),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: _isDark ? Colors.white : Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: _isDark,
                    activeColor: const Color(0xFF3B82F6),
                    onChanged: (val) {
                      setState(() => _isDark = val);
                      widget.onThemeChanged(val);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF334155)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: _isDark
                      ? const Color(0xFF131B2E)
                      : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    VoidCallback onTap,
    bool isDark,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFF64748B),
        size: 14,
      ),
    );
  }

  Widget _buildSubTile(
    IconData icon,
    String title,
    String trailingText,
    VoidCallback onTap,
    bool isDark,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trailingText,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF64748B),
            size: 14,
          ),
        ],
      ),
    );
  }
}
