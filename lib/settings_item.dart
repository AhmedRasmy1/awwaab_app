import 'package:awwaab_app/core/res/color_manager.dart';
import 'package:flutter/material.dart';
// متنساش تعمل import لملفات الـ Managers بتاعتك هنا
// import 'package:awwaab_app/core/res/color_manager.dart';
// import 'package:awwaab_app/core/res/values_manager.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing; // العنصر اللي في الآخر (سويتش، سهم، إلخ)
  final VoidCallback? onTap; // لما تدوس عليها يحصل إيه

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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white, // خلفية الكارت
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1),
        // ممكن تضيف BoxShadow هنا لو عايز ضل خفيف
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // حشوة داخلية
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: iconBGColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // 3. العنصر الأخير (Switch مثلاً)
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
