import 'package:flutter/material.dart';

class LinkedBanksView extends StatefulWidget {
  const LinkedBanksView({super.key});

  @override
  State<LinkedBanksView> createState() => _LinkedBanksViewState();
}

class _LinkedBanksViewState extends State<LinkedBanksView> {
  List<Map<String, String>> banks = [
    {'name': 'HNB Bank', 'account': '**** 4021', 'type': 'Savings'},
    {'name': 'BOC Bank', 'account': '**** 8832', 'type': 'Current'},
    {'name': 'People\'s Bank', 'account': '**** 1120', 'type': 'Savings'},
  ];

  void _showAddBankDialog() {
    final TextEditingController bankNameController = TextEditingController();
    final TextEditingController accNumController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text(
          'Link New Bank',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: bankNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Bank Name',
                labelStyle: TextStyle(color: Color(0xFF94A3B8)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: accNumController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Account Number',
                labelStyle: TextStyle(color: Color(0xFF94A3B8)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF94A3B8)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
            onPressed: () {
              if (bankNameController.text.isNotEmpty &&
                  accNumController.text.isNotEmpty) {
                setState(() {
                  banks.add({
                    'name': bankNameController.text,
                    'account': accNumController.text,
                    'type': 'Savings',
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

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
          'Linked Banks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: banks.length,
          itemBuilder: (context, index) {
            final bank = banks[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance,
                    color: Color(0xFF3B82F6),
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bank['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${bank['type']} · ${bank['account']}',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF34D399),
                    size: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3B82F6),
        onPressed: _showAddBankDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
