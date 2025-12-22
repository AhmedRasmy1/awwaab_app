import 'package:flutter/material.dart';

class FontSizeSettingsCard extends StatefulWidget {
  final double initialFontSize;
  final ValueChanged<double> onFontSizeChanged;

  const FontSizeSettingsCard({
    super.key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  });

  @override
  State<FontSizeSettingsCard> createState() => _FontSizeSettingsCardState();
}

class _FontSizeSettingsCardState extends State<FontSizeSettingsCard> {
  late double _currentFontSize;

  @override
  void initState() {
    super.initState();
    _currentFontSize = widget.initialFontSize;
  }

  String _getFontSizeLabel(double size) {
    if (size <= 14) return 'صغير';
    if (size <= 18) return 'متوسط';
    if (size <= 24) return 'كبير';
    return 'كبير جداً';
  }

  @override
  Widget build(BuildContext context) {
    // 1. تحديد الوضع الحالي
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;

    final double padding = screenWidth * 0.05;
    final double iconSize = screenWidth * 0.1;
    final double fontSizeLabel = screenWidth * 0.04;

    // 2. ألوان متغيرة حسب الثيم
    final Color primaryColor = Theme.of(context).primaryColor; // الأخضر بتاعنا
    final Color cardColor = isDark
        ? Theme.of(context).cardTheme.color!
        : Colors.white;
    final Color borderColor = isDark ? Colors.white12 : Colors.grey.shade300;

    final Color circleBG = isDark ? Colors.white10 : const Color(0xFFE8ECE9);
    final Color iconColor = isDark ? Colors.white : const Color(0xFF1F3C2E);
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    return Container(
      margin: EdgeInsets.symmetric(vertical: padding),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: cardColor, // متغير
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1), // متغير
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: circleBG, // متغير
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.text_fields_rounded,
                    color: iconColor, // متغير
                    size: iconSize * 0.5,
                  ),
                ),
              ),
              SizedBox(width: padding),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'حجم الخط',
                      style: TextStyle(
                        fontSize: fontSizeLabel,
                        fontWeight: FontWeight.bold,
                        color: textColor, // متغير
                      ),
                    ),
                    Text(
                      _getFontSizeLabel(_currentFontSize),
                      style: TextStyle(
                        fontSize: fontSizeLabel * 0.75,
                        color: subTextColor, // متغير
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: padding),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: primaryColor,
              inactiveTrackColor: isDark
                  ? Colors.grey.shade800
                  : const Color(0xFFE8ECE9), // تظبيط لون التراك
              thumbColor: Colors.white,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: iconSize * 0.3,
                elevation: 2,
              ),
              overlayColor: primaryColor.withOpacity(0.1),
              trackHeight: 12.0,
            ),
            child: Slider(
              value: _currentFontSize,
              min: 12.0,
              max: 30.0,
              divisions: 6,
              onChanged: (value) {
                setState(() {
                  _currentFontSize = value;
                });
                widget.onFontSizeChanged(value);
              },
            ),
          ),

          SizedBox(height: padding / 2),

          Center(
            child: Text(
              'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
              style: TextStyle(
                fontSize: _currentFontSize,
                color: textColor, // متغير عشان يبان
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
