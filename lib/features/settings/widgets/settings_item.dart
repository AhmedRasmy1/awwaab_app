import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = isDark
        ? Theme.of(context).cardTheme.color ?? const Color(0xFF242826)
        : Colors.white;

    final Color iconBGColor = isDark
        ? Colors.white.withOpacity(0.08)
        : const Color(0xFFE8ECE9);

    final Color iconColor = isDark ? Colors.white : const Color(0xFF1F3C2E);

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.1)
        : Colors.grey.shade300;

    final Color textColor =
        Theme.of(context).textTheme.bodyLarge?.color ??
        ColorManager.textPrimary;
    final Color subTextColor = isDark
        ? Colors.grey.shade400
        : ColorManager.textSecondary;

    final double borderRadius = 20.0;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: cardColor, // اللون المتغير
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1), // البوردر المتغير
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  decoration: BoxDecoration(
                    color: iconBGColor, // المتغير
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor, // المتغير
                    size: screenWidth * 0.06,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: textColor, // المتغير
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: subTextColor, // المتغير
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
