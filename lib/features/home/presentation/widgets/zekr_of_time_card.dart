import 'package:flutter/material.dart';

class ZekrOfTimeCard extends StatefulWidget {
  const ZekrOfTimeCard({super.key});

  @override
  State<ZekrOfTimeCard> createState() => _ZekrOfTimeCardState();
}

class _ZekrOfTimeCardState extends State<ZekrOfTimeCard> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark
        ? Theme.of(context).cardTheme.color!
        : Colors.white;
    final borderColor = isDark ? Colors.white12 : Colors.grey.shade300;
    final primaryTextColor = isDark ? Colors.white : const Color(0xFF1F3C2E);
    final secondaryTextColor = isDark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    final circleColor = const Color(0xFF1F3C2E);
    final counterTextColor = Colors.white;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "ذكر مناسب للوقت",
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
              fontFamily: 'AmiriQuran',
            ),
          ),

          const SizedBox(height: 30),

          InkWell(
            onTap: _incrementCounter,
            customBorder: const CircleBorder(),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: circleColor.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "$_counter",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: counterTextColor,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: _resetCounter,
            style: TextButton.styleFrom(foregroundColor: secondaryTextColor),
            child: Text(
              "إعادة تعيين",
              style: TextStyle(fontSize: 14, color: secondaryTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
