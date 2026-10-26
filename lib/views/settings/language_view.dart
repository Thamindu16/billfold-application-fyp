import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  final bool isDarkMode;
  const LanguageView({super.key, required this.isDarkMode});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  String selectedLanguage = 'English';
  final List<String> languages = ['English', 'Sinhala', 'Tamil'];

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
          'Language',
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final lang = languages[index];
            bool isSelected = selectedLanguage == lang;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF131B2E)
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : (widget.isDarkMode
                            ? const Color(0xFF1E293B)
                            : Colors.grey.shade300),
                ),
              ),
              child: ListTile(
                onTap: () => setState(() => selectedLanguage = lang),
                title: Text(
                  lang,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : (widget.isDarkMode ? Colors.white : Colors.black87),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: Color(0xFF3B82F6))
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
