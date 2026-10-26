import 'package:flutter/material.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  String selectedCurrency = 'LKR';
  final List<String> currencies = ['LKR', 'USD', 'EUR', 'GBP', 'AUD', 'JPY'];

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
          'Preferred Currency',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, index) {
            final currency = currencies[index];
            bool isSelected = selectedCurrency == currency;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF1E293B),
                ),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    selectedCurrency = currency;
                  });
                },
                title: Text(
                  currency,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
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
