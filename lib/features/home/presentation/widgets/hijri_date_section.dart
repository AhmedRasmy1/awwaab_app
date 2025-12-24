import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class HijriDateSection extends StatefulWidget {
  const HijriDateSection({super.key});

  @override
  State<HijriDateSection> createState() => _HijriDateSectionState();
}

class _HijriDateSectionState extends State<HijriDateSection> {
  bool _isEventVisible = true;

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    final HijriCalendar today = HijriCalendar.now();
    final String hijriDate = "${today.toFormat("dd MMMM yyyy")} هـ";
    final String? eventText = _getHijriEvent(today);
    final bool hasEvent = eventText != null;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              if (hasEvent) {
                setState(() {
                  _isEventVisible = true;
                });
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (hasEvent && !_isEventVisible)
                      ? primaryColor.withOpacity(0.5)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                hijriDate,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ),
        if (hasEvent && _isEventVisible) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.stars_rounded, color: primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "حدث اليوم",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        eventText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _isEventVisible = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String? _getHijriEvent(HijriCalendar date) {
    if (date.wkDay == 1 || date.wkDay == 4)
      return "يستحب صيام هذا اليوم (إثنين/خميس).";
    if (date.hDay >= 13 && date.hDay <= 15)
      return "الأيام البيض (يستحب الصيام).";
    if (date.hMonth == 9) return "شهر رمضان المبارك.";
    if (date.hMonth == 12 && date.hDay == 9) return "يوم عرفة.";
    if (date.hMonth == 1 && date.hDay == 10) return "يوم عاشوراء.";

    return null;
  }
}
