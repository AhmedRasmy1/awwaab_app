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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double padding = screenWidth * 0.05; // 5% of screen width
    final double iconSize = screenWidth * 0.1; // 10% of screen width
    final double fontSizeLabel = screenWidth * 0.04; // 4% of screen width

    final Color primaryColor = const Color(0xFF1F3C2E);
    final Color circleBG = const Color(0xFFE8ECE9);

    return Container(
      margin: EdgeInsets.symmetric(vertical: padding),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
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
                  color: circleBG,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.text_fields_rounded,
                    color: primaryColor,
                    size: iconSize * 0.5, // 50% of icon size
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
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      _getFontSizeLabel(_currentFontSize),
                      style: TextStyle(
                        fontSize:
                            fontSizeLabel * 0.75, // 75% of label font size
                        color: Colors.grey.shade600,
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
              inactiveTrackColor: circleBG,
              thumbColor: Colors.white,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: iconSize * 0.3, // 30% of icon size
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
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
