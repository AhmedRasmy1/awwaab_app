import 'package:flutter/material.dart';

class PrayerHeaderSection extends StatelessWidget {
  final String cityName;

  const PrayerHeaderSection({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust padding and font size based on screen width
    final padding = screenWidth * 0.01; // 2% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              cityName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
                fontFamily: 'Cairo',
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // Allow up to 2 lines
            ),
          ),
        ],
      ),
    );
  }
}
