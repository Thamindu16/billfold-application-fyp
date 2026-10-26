import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  final bool isDarkMode;
  NotificationsView({super.key, required this.isDarkMode});

  final List<Map<String, String>> notifications = [
    {
      'section': 'Today',
      'title': 'AI assistant',
      'desc': 'Your January summary is ready to view',
      'time': '2 mins ago',
      'type': 'ai',
    },
    {
      'section': 'Today',
      'title': 'Document processed',
      'desc': 'HNB_Statement_Jan.pdf has been encrypted & analyzed',
      'time': '15 mins ago',
      'type': 'doc',
    },
    {
      'section': 'Yesterday',
      'title': 'Security alert',
      'desc': 'New login detected from this device',
      'time': 'Yesterday, 9:40 PM',
      'type': 'security',
    },
    {
      'section': 'Yesterday',
      'title': 'Insight',
      'desc': 'Your electricity bill is 12% higher than last month',
      'time': 'Yesterday, 6:15 PM',
      'type': 'insight',
    },
    {
      'section': 'This week',
      'title': 'Upload complete',
      'desc': 'BOC_Statement_Jan.pdf processed successfully',
      'time': '3 days ago',
      'type': 'upload',
    },
  ];

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
          'Notifications',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          bool showSectionHeader =
              index == 0 ||
              notifications[index - 1]['section'] != item['section'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showSectionHeader) ...[
                if (index > 0) const SizedBox(height: 16),
                Text(
                  item['section']!,
                  style: TextStyle(
                    color: isDarkMode
                        ? const Color(0xFF94A3B8)
                        : Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF131B2E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.notifications_active_outlined,
                        color: Color(0xFF3B82F6),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['desc']!,
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['time']!,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
