import 'package:awwaab_app/core/res/allah_names_data.dart';
import 'package:flutter/material.dart';

class AllahNameCard extends StatelessWidget {
  const AllahNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(DateTime(2000, 1, 1)).inDays;
    final int index = difference % AllahNamesData.names.length;
    final AllahNameModel todaysName = AllahNamesData.names[index];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? Theme.of(context).cardTheme.color!
        : const Color(0xFFF9F5EB);
    final borderColor = isDark ? Colors.white12 : const Color(0xFFE3DCC8);
    final nameColor = const Color(0xFFC8B88A);
    final textColor = isDark ? Colors.grey.shade300 : const Color(0xFF1F3C2E);

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final circleSize = isSmallScreen ? 60.0 : 80.0;
    final nameTextSize = isSmallScreen ? 12.0 : 16.0;
    final padding = isSmallScreen ? 12.0 : 20.0;
    final spacing = isSmallScreen ? 12.0 : 20.0;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 8 : 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              children: [
                Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: nameColor.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: nameColor.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      todaysName.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: nameTextSize,
                        fontWeight: FontWeight.w400,
                        color: nameColor,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم من أسماء الله الحسنى",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 10 : 12,
                          fontFamily: 'Cairo',
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 6),
                      Text(
                        todaysName.meaning,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          height: 1.5,
                          fontFamily: 'Cairo',
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
