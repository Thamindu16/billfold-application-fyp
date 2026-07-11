import 'package:flutter/material.dart';

// VIVA INFO: Changed to a standard view class that can be called safely without strict const mismatch
class AiChatView extends StatefulWidget {
  // Added a proper nullable key constructor to allow flexible navigation from Dashboard
  const AiChatView({Key? key}) : super(key: key);

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  // Controller to handle and clear the text input field
  final TextEditingController _chatController = TextEditingController();

  // Hardcoded chat history to simulate real AI conversation with data citations
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text':
          'Hi! I have analyzed your uploaded documents. You can ask me any questions about your bank statements or payslips.',
      'hasCitation': false,
      'citation': '',
    },
    {
      'isUser': true,
      'text': 'What was my total electricity bill payment for last month?',
      'hasCitation': false,
      'citation': '',
    },
    {
      'isUser': false,
      'text':
          'Your total electricity bill payment was LKR 4,520. This was paid on January 14, 2026.',
      'hasCitation':
          true, // Displays the citation button for this specific AI response
      'citation':
          'Source: HNB_Statement_Jan.pdf • Page 2 • Row 14 (CEB Auto-Debit)',
    },
  ];

  // Function to add user's typed message to the list and refresh the screen
  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return; // Stop if input is empty
    setState(() {
      _messages.add({
        'isUser': true,
        'text': _chatController.text,
        'hasCitation': false,
        'citation': '',
      });
      _chatController.clear(); // Clear input field after sending
    });
  }

  // Clean up the text controller when leaving the screen to prevent memory leaks
  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1A36), // Deep navy background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1A36),
        elevation: 0,
        // Back button to return to the Dashboard screen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // Title block showing App Name and subtitle
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 20),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BILLFOLD Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Local AI • Privacy Guaranteed",
                  style: TextStyle(color: Colors.greenAccent, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Expanded list area that automatically scrolls and displays chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(
                  msg,
                ); // Generate a UI bubble for each message
              },
            ),
          ),

          // Bottom input area where user types text
          _buildInputArea(),
        ],
      ),
    );
  }

  // Helper widget to construct individual message bubbles (User vs AI styling)
  Widget _buildChatBubble(Map<String, dynamic> msg) {
    bool isUser = msg['isUser'];
    return Align(
      // Align user messages to right, AI messages to left
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor:
            0.75, // Safely caps the chat bubble width to 75% of screen width without context errors
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: isUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // Main message text box
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isUser
                      ? const Color(0xFF2F66F6)
                      : const Color(
                          0xFF1E2A4A,
                        ), // Blue for user, Grey-blue for AI
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(
                      isUser ? 16 : 0,
                    ), // Sharp corner logic for left/right side
                    bottomRight: Radius.circular(isUser ? 0 : 16),
                  ),
                ),
                child: Text(
                  msg['text'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ),
              // Conditional button: Renders only if the AI response has a source citation
              if (msg['hasCitation']) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    _showCitationDialog(
                      msg['citation'],
                    ); // Trigger popup with source details
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book,
                          color: Colors.blueAccent,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "View Citation",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget containing the text field and send button at the bottom
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0F1A36),
      child: SafeArea(
        child: Row(
          children: [
            // Rounded container acting as the background for the text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2A4A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _chatController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Ask about your statements...",
                    hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Circular blue send button
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF2F66F6),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: _sendMessage, // Triggers message sending when tapped
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a clean pop-up modal containing the AI source document info
  void _showCitationDialog(String citationText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2A4A),
        title: const Row(
          children: [
            Icon(
              Icons.verified_user_outlined,
              color: Colors.greenAccent,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              "AI Citation Grounding",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          citationText,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close popup box
            child: const Text(
              "Close",
              style: TextStyle(color: Color(0xFF2F66F6)),
            ),
          ),
        ],
      ),
    );
  }
}
