import 'package:flutter/material.dart';
import '../document/pdf_overview_view.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final bool hasCitation;
  final String? citationTitle;
  final String? citationPage;
  final String? citationDetailTitle;
  final String? citationPayment;
  final String? citationDate;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.hasCitation = false,
    this.citationTitle,
    this.citationPage,
    this.citationDetailTitle,
    this.citationPayment,
    this.citationDate,
  });
}

class AiChatView extends StatefulWidget {
  AiChatView({super.key});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Hi! I\'ve analyzed your uploaded documents. Ask me anything about your bank statements or payslips.',
      isUser: false,
    ),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      String replyText =
          'I have processed your query based on your secure vault records.';
      bool showCitation = false;
      String docTitle = 'HNB_Statement_Jan.pdf';
      String pageNum = 'Page 2';
      String detailTitle = 'Transaction record';
      String paymentAmount = 'LKR 0';
      String txDate = '14/01/2026';

      final lowerQuery = text.toLowerCase();

      if (lowerQuery.contains('expense') ||
          lowerQuery.contains('total') ||
          lowerQuery.contains('spend')) {
        replyText =
            'Your total expenses for January were LKR 68,200, mainly covering electricity, groceries, and rent payments.';
        showCitation = true;
        docTitle = 'HNB_Statement_Jan.pdf';
        pageNum = 'Page 2';
        detailTitle = 'Electricity bill';
        paymentAmount = 'LKR 4,520';
        txDate = '14/01/2026';
      } else if (lowerQuery.contains('income') ||
          lowerQuery.contains('salary') ||
          lowerQuery.contains('pay')) {
        replyText =
            'Your total income recorded for January is LKR 145,000 including your primary salary deposit.';
        showCitation = true;
        docTitle = 'Slip_Pay_2026.pdf';
        pageNum = 'Page 1';
        detailTitle = 'Salary deposit';
        paymentAmount = '+LKR 145,000';
        txDate = '01/01/2026';
      } else if (lowerQuery.contains('pdf') ||
          lowerQuery.contains('statement') ||
          lowerQuery.contains('show') ||
          lowerQuery.contains('file') ||
          lowerQuery.contains('view')) {
        replyText =
            'Here is the requested statement document details. You can review the full document directly using the citation below.';
        showCitation = true;
        docTitle = 'HNB_Statement_Jan.pdf';
        pageNum = 'Page 1';
        detailTitle = 'HNB Bank Statement Jan 2026';
        paymentAmount = 'Processed';
        txDate = 'Today';
      } else {
        replyText =
            'I found relevant details in your vault regarding "$text". You can open the full statement to review all breakdowns.';
        showCitation = true;
        docTitle = 'HNB_Statement_Jan.pdf';
        pageNum = 'Page 1';
        detailTitle = 'General Vault Record';
        paymentAmount = 'Matched';
        txDate = 'Today';
      }

      setState(() {
        _messages.add(
          ChatMessage(
            text: replyText,
            isUser: false,
            hasCitation: showCitation,
            citationTitle: docTitle,
            citationPage: pageNum,
            citationDetailTitle: detailTitle,
            citationPayment: paymentAmount,
            citationDate: txDate,
          ),
        );
      });

      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showCitationModal(
    BuildContext context, {
    required String title,
    required String page,
    required String detailTitle,
    required String payment,
    required String date,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131B2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Source',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
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
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        page,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          'Info: ',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Text(
                          payment,
                          style: const TextStyle(
                            color: Color(0xFF4ADE80),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'Date: ',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Color(0xFF4ADE80),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B7FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfOverviewView(title: title),
                      ),
                    );
                  },
                  child: const Text(
                    'View full document',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI financial assistant',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Local AI · Privacy guaranteed',
              style: TextStyle(color: Color(0xFF34D399), fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: message.isUser ? null : const Color(0xFF1E293B),
                      gradient: message.isUser
                          ? const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        if (message.hasCitation) ...[
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () => _showCitationModal(
                              context,
                              title:
                                  message.citationTitle ??
                                  'HNB_Statement_Jan.pdf',
                              page: message.citationPage ?? 'Page 2',
                              detailTitle:
                                  message.citationDetailTitle ??
                                  'Transaction record',
                              payment: message.citationPayment ?? 'LKR 0',
                              date: message.citationDate ?? '14/01/2026',
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2563EB).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.description_outlined,
                                    color: Color(0xFF5B7FFF),
                                    size: 14,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'View citation',
                                    style: TextStyle(
                                      color: Color(0xFF8DA4FF),
                                      fontSize: 12,
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
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Ask about your statements...',
                        hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5B7FFF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
