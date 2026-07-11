import 'package:flutter/material.dart';
// Importing using your exact filename 'chat_view.dart' to fix the error
import '../chat/chat_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // Mock list simulating documents fetched from the database
  final List<Map<String, dynamic>> _uploadedDocs = [
    {
      'name': 'HNB_Statement_Jan.pdf',
      'type': 'Bank Statement',
      'date': 'Today',
    },
    {'name': 'Slip_Pay_2026.pdf', 'type': 'Payslip', 'date': 'Yesterday'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1A36), // Deep navy background theme
      // Sidebar drawer menu accessible from the top-left corner
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF0F1A36),
          child: const Center(
            child: Text(
              "Sidebar Menu",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1A36),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Colors the hamburger icon white
        title: const Text(
          "BILLFOLD",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Profile icon button on the top right
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white70,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top greeting banner widget
            _buildWelcomeCard(),
            const SizedBox(height: 24),

            // Document Upload UI section header
            const Text(
              "Upload Statements",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildUploadZone(),
            const SizedBox(height: 24),

            // Financial breakdown section header
            const Text(
              "Extracted Overview",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInsightMiniChart(),
            const SizedBox(height: 24),

            // Processed document archive list header
            const Text(
              "Processed Documents",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildDocumentList(),
          ],
        ),
      ),

      // Floating button that redirects user to the AI Chat screen
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigates safely to AiChatView since the correct file is imported above
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AiChatView()),
          );
        },
        backgroundColor: const Color(0xFF2F66F6), // Accent theme blue
        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        label: const Text(
          "Ask Assistant",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Builder widget for the greeting and privacy disclosure banner
  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2F66F6), Color(0xFF1A44B3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello User 👋",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 6),
          const Text(
            "Privacy-Safe Financial Intelligence",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Upload your personal bank statements or payslips. Our local AI will analyze them securely without cloud data exposure.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Builder widget for the interactive PDF file drop zone
  Widget _buildUploadZone() {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A4A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          // File picking logic goes here in future updates
        },
        borderRadius: BorderRadius.circular(16),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              color: Colors.blueAccent,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              "Tap to upload PDF statement",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Supports Bank Statements, Payslips & Budgets",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Builder widget displaying basic dynamic extractions (Income vs Expense summaries)
  Widget _buildInsightMiniChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A4A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInsightStat("Total Income", "LKR 145,000", Colors.greenAccent),
          Container(width: 1, height: 50, color: Colors.white12),
          _buildInsightStat("Total Expense", "LKR 68,200", Colors.redAccent),
        ],
      ),
    );
  }

  // Helper template method to structure single financial data boxes smoothly
  Widget _buildInsightStat(String title, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Builder widget rendering the dynamic file rows underneath the dashboard
  Widget _buildDocumentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _uploadedDocs.length,
      itemBuilder: (context, index) {
        final doc = _uploadedDocs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A4A).withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.picture_as_pdf,
              color: Colors.redAccent,
              size: 30,
            ),
            title: Text(
              doc['name'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              "${doc['type']} • ${doc['date']}",
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white30,
              size: 14,
            ),
            onTap: () {
              // Action logic for clicking individual files will map here
            },
          ),
        );
      },
    );
  }
}
