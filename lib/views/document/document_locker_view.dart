import 'package:flutter/material.dart';

class DocumentLockerView extends StatefulWidget {
  const DocumentLockerView({super.key});

  @override
  State<DocumentLockerView> createState() => _DocumentLockerViewState();
}

class _DocumentLockerViewState extends State<DocumentLockerView> {
  // ඔයා හදපු dynamic files list එක
  final List<Map<String, dynamic>> _savedFiles = [
    {
      'name': 'HNB_Statement_Jan.pdf',
      'size': '1.2 MB',
      'uploaded': '2026-07-12',
      'status': 'Encrypted',
    },
    {
      'name': 'Slip_Pay_2026.pdf',
      'size': '450 KB',
      'uploaded': '2026-07-11',
      'status': 'Encrypted',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1A36),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1A36),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // ආපහු Dashboard එකට ආරක්ෂිතව යන්න
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.lock_outline, color: Colors.blueAccent, size: 22),
            SizedBox(width: 8),
            Text(
              "Document Locker",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active sandbox security banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2A4A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.greenAccent.withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: Colors.greenAccent,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Local Encryption Active",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "All documents are stored safely with local sandbox security.",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Stored Documents",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Files List view builder
            Expanded(
              child: _savedFiles.isEmpty
                  ? const Center(
                      child: Text(
                        "No documents secured yet",
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _savedFiles.length,
                      itemBuilder: (context, index) {
                        final file = _savedFiles[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF1E2A4A,
                            ).withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF0F1A36),
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Colors.blueAccent,
                              ),
                            ),
                            title: Text(
                              file['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              "${file['size']} • Stored: ${file['uploaded']}",
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                file['status'],
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
