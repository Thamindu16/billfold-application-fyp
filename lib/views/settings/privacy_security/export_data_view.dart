import 'package:flutter/material.dart';

class ExportDataView extends StatefulWidget {
  final bool isDarkMode;
  const ExportDataView({super.key, required this.isDarkMode});

  @override
  State<ExportDataView> createState() => _ExportDataViewState();
}

class _ExportDataViewState extends State<ExportDataView> {
  bool includeDocuments = true;
  bool includeTransactions = true;
  bool includeChatHistory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? const Color(0xFF0B1120)
          : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: widget.isDarkMode ? Colors.white70 : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Export My Data',
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select data to include in export archive.',
              style: TextStyle(
                color: widget.isDarkMode
                    ? const Color(0xFF94A3B8)
                    : Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF131B2E)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.isDarkMode
                      ? const Color(0xFF1E293B)
                      : Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Encrypted Documents',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    value: includeDocuments,
                    activeColor: const Color(0xFF3B82F6),
                    onChanged: (val) => setState(() => includeDocuments = val),
                  ),
                  Divider(
                    height: 1,
                    color: widget.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  SwitchListTile(
                    title: Text(
                      'Financial Transactions',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    value: includeTransactions,
                    activeColor: const Color(0xFF3B82F6),
                    onChanged: (val) =>
                        setState(() => includeTransactions = val),
                  ),
                  Divider(
                    height: 1,
                    color: widget.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade200,
                  ),
                  SwitchListTile(
                    title: Text(
                      'AI Chat History',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    value: includeChatHistory,
                    activeColor: const Color(0xFF3B82F6),
                    onChanged: (val) =>
                        setState(() => includeChatHistory = val),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export request initiated.')),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Request Export Archive',
                  style: TextStyle(
                    color: Colors.white,
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
}
