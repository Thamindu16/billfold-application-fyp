import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;

  double totalIncome = 145000.0;
  double totalExpense = 68200.0;

  List<Map<String, String>> processedDocuments = [
    {
      'title': 'HNB_Statement_Jan.pdf',
      'subtitle': 'Bank statement · Today',
      'status': 'Encrypted',
    },
    {
      'title': 'Slip_Pay_2026.pdf',
      'subtitle': 'Payslip · Yesterday',
      'status': 'Encrypted',
    },
  ];

  void _onUploadPDF() {
    setState(() {
      totalIncome += 25000.0;
      totalExpense += 5000.0;
      processedDocuments.insert(0, {
        'title': 'New_Statement_${DateTime.now().day}.pdf',
        'subtitle': 'Bank statement · Just now',
        'status': 'Encrypted',
      });
    });
  }

  void _navigateToPage(String pageTitle) {
    if (pageTitle == 'Document locker' || pageTitle == 'Document Locker') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DocumentLockerView()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceholderPage(title: pageTitle),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Customized Sidebar Drawer matching the image design exactly
      drawer: Drawer(
        backgroundColor: const Color(0xFF090D16),
        child: SafeArea(
          child: Column(
            children: [
              // User Profile Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF253368),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'TP',
                          style: TextStyle(
                            color: Color(0xFF5B7FFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thamindu Kavinda',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Premium tier plan',
                          style: TextStyle(
                            color: Color(0xFF2E8B57),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white10, height: 1),
              const SizedBox(height: 16),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  children: [
                    // Dashboard Overview (Selected item styling)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.home_outlined,
                          color: Color(0xFF5B7FFF),
                        ),
                        title: const Text(
                          'Dashboard overview',
                          style: TextStyle(
                            color: Color(0xFF8DA4FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _currentIndex = 0);
                        },
                      ),
                    ),
                    const SizedBox(height: 6),

                    // AI Assistant Chat
                    ListTile(
                      leading: const Icon(Icons.search, color: Colors.white54),
                      title: const Text(
                        'AI assistant chat',
                        style: TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _navigateToPage('AI assistant chat');
                      },
                    ),
                    const SizedBox(height: 6),

                    // Document Locker
                    ListTile(
                      leading: const Icon(
                        Icons.folder_outlined,
                        color: Colors.white54,
                      ),
                      title: const Text(
                        'Document locker',
                        style: TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() => _currentIndex = 1);
                        _navigateToPage('Document locker');
                      },
                    ),
                    const SizedBox(height: 6),

                    // Settings
                    ListTile(
                      leading: const Icon(
                        Icons.access_time,
                        color: Colors.white54,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() => _currentIndex = 2);
                        _navigateToPage('Settings');
                      },
                    ),
                  ],
                ),
              ),

              // Bottom Log Out Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF111726),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Color(0xFFE57373)),
                    title: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Color(0xFFE57373),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Implement actual user logout logic here
                      _navigateToPage('Logged Out');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          child: Builder(
            builder: (context) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        const Text(
                          'BILLFOLD',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateToPage('Profile');
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF2563EB,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'TP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withOpacity(0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'INTELLIGENT VAULT',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Secure financial hub',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Statements are analyzed on a private server and encrypted end to end. Nothing is shared with third parties.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Upload statements',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _onUploadPDF,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF334155)),
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: Color(0xFF3B82F6),
                              size: 32,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Tap to upload PDF statement',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Bank statements, payslips, or budgets',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF334155),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total income',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'LKR ${totalIncome.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4ADE80),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF334155),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total expense',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'LKR ${totalExpense.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF87171),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Processed documents',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: processedDocuments.length,
                      itemBuilder: (context, index) {
                        final doc = processedDocuments[index];
                        return GestureDetector(
                          onTap: () {
                            _navigateToPage('PDF Overview: ${doc['title']}');
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF334155),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF2563EB,
                                    ).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.insert_drive_file_outlined,
                                    color: Color(0xFF3B82F6),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc['title']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        doc['subtitle']!,
                                        style: const TextStyle(
                                          color: Color(0xFF94A3B8),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    doc['status']!,
                                    style: const TextStyle(
                                      color: Color(0xFF34D399),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          _navigateToPage('AI Assistant Chat');
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2563EB).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Dashboard Overview
          } else if (index == 1) {
            _navigateToPage('Document locker');
          } else if (index == 2) {
            _navigateToPage('Settings');
          }
        },
        backgroundColor: const Color(0xFF0B1120),
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: const Color(0xFF64748B),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Locker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class DocumentLockerView extends StatefulWidget {
  const DocumentLockerView({super.key});

  @override
  State<DocumentLockerView> createState() => _DocumentLockerViewState();
}

class _DocumentLockerViewState extends State<DocumentLockerView> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> documents = [
    {
      'name': 'HNB_Statement_Jan.pdf',
      'type': 'Bank statement',
      'date': 'Today',
    },
    {
      'name': 'BOC_Statement_Jan.pdf',
      'type': 'Bank statement',
      'date': '2 days ago',
    },
    {
      'name': 'Peoples_Statement_Jan.pdf',
      'type': 'Bank statement',
      'date': '5 days ago',
    },
  ];

  List<Map<String, String>> filteredDocuments = [];

  @override
  void initState() {
    super.initState();
    filteredDocuments = documents;
    _searchController.addListener(_filterDocuments);
  }

  void _filterDocuments() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDocuments = documents.where((doc) {
        final name = doc['name']!.toLowerCase();
        final type = doc['type']!.toLowerCase();
        return name.contains(query) || type.contains(query);
      }).toList();
    });
  }

  Future<void> _addNewDocument() async {
    final XFile? file = await openFile();
    if (file != null) {
      setState(() {
        documents.add({
          'name': file.name,
          'type': 'Bank statement',
          'date': 'Just now',
        });
        _filterDocuments();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Document locker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.lock_outline, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Local sandbox encryption active',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'All statements are encrypted at rest',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search documents',
                  hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'All statements (${filteredDocuments.length})',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final doc = filteredDocuments[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF334155)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${doc['type']} · ${doc['date']}',
                                style: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Encrypted',
                            style: TextStyle(
                              color: Color(0xFF34D399),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDocument,
        backgroundColor: const Color(0xFF2563EB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B1120),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
        child: Center(
          child: Text(
            '$title Page\n(Under Development)',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
