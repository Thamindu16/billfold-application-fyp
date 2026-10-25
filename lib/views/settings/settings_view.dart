import 'package:flutter/material.dart';

// 1. My Profile View
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('My profile', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: const Center(
        child: Text(
          'Profile details and edits',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

// 2. Privacy & Security View
class PrivacySecurityView extends StatelessWidget {
  const PrivacySecurityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Privacy & security',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: const Center(
        child: Text(
          'Manage your security and privacy settings',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

// 3. Notifications View
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: const Center(
        child: Text(
          'Notification preferences',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

// 4. Language View
class LanguageView extends StatelessWidget {
  const LanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Language', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: const Center(
        child: Text(
          'Select preferred language (English)',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

// 5. Currency View
class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Currency', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: const Center(
        child: Text(
          'Currency settings (Default: LKR)',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

// 6. About / App Version View
class AboutView extends StatelessWidget {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'About / app version',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: const Center(
        child: Text(
          'BILLFOLD App Version 1.0.0\nSecure Financial Hub',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

// Main Settings View
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.person_outline,
                    title: 'My profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFF1E293B)),
                  _buildSettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Privacy & security',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacySecurityView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFF1E293B)),
                  _buildSettingsTile(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'General',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    trailingText: 'English',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFF1E293B)),
                  _buildSettingsTile(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Currency',
                    trailingText: 'LKR',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CurrencyView(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFF1E293B)),
                  _buildSettingsTile(
                    icon: Icons.access_time_outlined,
                    title: 'About / app version',
                    trailingText: '1.0.0',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutView(),
                        ),
                      );
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
                  backgroundColor: const Color(0xFF131B2E),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color(0xFF131B2E),
                      title: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Color(0xFF94A3B8)),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Log out',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  );
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

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            ),
          if (trailingText != null) const SizedBox(width: 8),
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
