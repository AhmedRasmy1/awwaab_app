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
    final Color iconBGColor = const Color(0xFFE8ECE9);
    final Color iconColor = const Color(0xFF1F3C2E);
    final Color borderColor = Colors.grey.shade300;
    final double borderRadius = 20.0;

    // Get screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    screenWidth * 0.025,
                  ), // Responsive padding
                  decoration: BoxDecoration(
                    color: iconBGColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: screenWidth * 0.06,
                  ), // Responsive icon size
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.035, // Responsive font size
                            color: ColorManager.textSecondary,
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
