import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';

class DocumentLockerView extends StatefulWidget {
  const DocumentLockerView({Key? key}) : super(key: key);

  @override
  State<DocumentLockerView> createState() => _DocumentLockerViewState();
}

class _DocumentLockerViewState extends State<DocumentLockerView> {
  int _currentIndex = 1; // Locker is selected by default
  final TextEditingController _searchController = TextEditingController();

  // Initial document list matching the design
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

  // Search filter functionality
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

  // Function to add new document using file selector
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
      backgroundColor: const Color(
        0xFF0D1322,
      ), // App theme dark background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sandbox encryption active banner card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B5BDB), Color(0xFF7048E8)],
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

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A2238),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search documents',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Statement count header
            Text(
              'All statements (${filteredDocuments.length})',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            // Document List view
            Expanded(
              child: ListView.builder(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final doc = filteredDocuments[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161F37),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2B42),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: Color(0xFFE5989B),
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
                                  color: Colors.white54,
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
                            color: const Color(0xFF133824),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Encrypted',
                            style: TextStyle(
                              color: Color(0xFF4E9F3D),
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

      // Floating Action Button to add new documents
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDocument,
        backgroundColor: const Color(0xFF7048E8),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // Bottom Navigation Bar with Home, Locker, and Settings
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D1322),
        selectedItemColor: const Color(0xFF7048E8),
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // TODO: Navigate to Home Page when created
            // Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            // Currently on Locker Page
          } else if (index == 2) {
            // TODO: Navigate to Settings Page when created
            // Navigator.pushNamed(context, '/settings');
          }
        },
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
