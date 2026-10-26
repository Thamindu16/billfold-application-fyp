import 'package:flutter/material.dart';
import 'row_level_security_view.dart';
import 'storage_view.dart';
import 'third_party_ai_view.dart';
import 'documents_encrypted_view.dart';
import 'auto_delete_view.dart';
import 'export_data_view.dart';
import 'delete_data_view.dart';

class PrivacySecurityView extends StatelessWidget {
  final bool isDarkMode;
  const PrivacySecurityView({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF0B1120) : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Privacy & security',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.lock_outline, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'PRIVACY-FIRST ARCHITECTURE',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Your data, protected',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Documents are processed on a private authenticated server and never shared with third-party AI providers.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildHeader('Data protection', isDarkMode),
            const SizedBox(height: 10),
            _buildCard(isDarkMode, [
              _buildNavTile(Icons.security, 'Row-level security', 'Active', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RowLevelSecurityView(isDarkMode: isDarkMode),
                  ),
                );
              }, isDarkMode),
              const Divider(height: 1, color: Color(0xFF1E293B)),
              _buildNavTile(Icons.storage, 'Storage', 'Supabase', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StorageView(isDarkMode: isDarkMode),
                  ),
                );
              }, isDarkMode),
              const Divider(height: 1, color: Color(0xFF1E293B)),
              _buildNavTile(Icons.block, 'Third-party AI access', 'None', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ThirdPartyAiView(isDarkMode: isDarkMode),
                  ),
                );
              }, isDarkMode),
            ]),
            const SizedBox(height: 24),
            _buildHeader('Document security', isDarkMode),
            const SizedBox(height: 10),
            _buildCard(isDarkMode, [
              _buildNavTile(
                Icons.enhanced_encryption,
                'Documents encrypted',
                'Active',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DocumentsEncryptedView(isDarkMode: isDarkMode),
                    ),
                  );
                },
                isDarkMode,
              ),
              const Divider(height: 1, color: Color(0xFF1E293B)),
              _buildNavTile(Icons.timer, 'Auto-delete', '30 days', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AutoDeleteView(isDarkMode: isDarkMode),
                  ),
                );
              }, isDarkMode),
            ]),
            const SizedBox(height: 24),
            _buildHeader('Your controls', isDarkMode),
            const SizedBox(height: 10),
            _buildCard(isDarkMode, [
              _buildActionTile(Icons.download, 'Export my data', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ExportDataView(isDarkMode: isDarkMode),
                  ),
                );
              }, isDarkMode),
              const Divider(height: 1, color: Color(0xFF1E293B)),
              _buildActionTile(
                Icons.delete_outline,
                'Delete all my data',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DeleteDataView(isDarkMode: isDarkMode),
                    ),
                  );
                },
                isDarkMode,
                isDestructive: true,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        color: isDark ? const Color(0xFF94A3B8) : Colors.grey[600],
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildCard(bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade300,
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildNavTile(
    IconData icon,
    String title,
    String badgeText,
    VoidCallback onTap,
    bool isDark,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 15,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeText == 'Active' || badgeText == 'Supabase'
                  ? const Color(0xFF10B981).withOpacity(0.15)
                  : Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                color: badgeText == 'Active' || badgeText == 'Supabase'
                    ? const Color(0xFF34D399)
                    : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
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

  Widget _buildActionTile(
    IconData icon,
    String title,
    VoidCallback onTap,
    bool isDark, {
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? Colors.redAccent : const Color(0xFF3B82F6),
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive
              ? Colors.redAccent
              : (isDark ? Colors.white : Colors.black87),
          fontSize: 15,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFF64748B),
        size: 14,
      ),
    );
  }
}
