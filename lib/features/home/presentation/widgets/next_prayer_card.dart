import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:awwaab_app/core/utils/cashed_data_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextPrayerCard extends StatefulWidget {
  const NextPrayerCard({super.key});

  @override
  State<NextPrayerCard> createState() => _NextPrayerCardState();
}

class _NextPrayerCardState extends State<NextPrayerCard> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  // متغيرات لعرض البيانات
  String _nextPrayerName = "--";
  String _nextPrayerTimeDisplay = "--:--";
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _calculateNextPrayer(); // 1. ابدأ الحساب أول ما الكارت يظهر
  }

  // دالة الحساب الرئيسية
  Future<void> _calculateNextPrayer() async {
    try {
      // أ) هات الإحداثيات من الكاش
      final lat = CacheService.getData(key: 'cached_lat');
      final lng = CacheService.getData(key: 'cached_lng');

      if (lat == null || lng == null) {
        if (mounted) {
          setState(() {
            _nextPrayerName = "حدد الموقع";
            _nextPrayerTimeDisplay = "00:00";
            _isLoading = false;
            _hasError = true;
          });
        }
        return;
      }

      // ب) إعدادات الحساب
      final coordinates = Coordinates(lat, lng);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      // ج) حساب مواقيت اليوم وبكرة
      final now = DateTime.now();
      final todayComponents = DateComponents.from(now);
      final tomorrowComponents = DateComponents.from(
        now.add(const Duration(days: 1)),
      );

      final todayPrayers = PrayerTimes(coordinates, todayComponents, params);
      final tomorrowPrayers = PrayerTimes(
        coordinates,
        tomorrowComponents,
        params,
      );

      // د) تحديد الصلاة القادمة
      Prayer next = todayPrayers.nextPrayer();
      DateTime? nextTime;

      if (next == Prayer.none) {
        next = Prayer.fajr;
        nextTime = tomorrowPrayers.fajr;
      } else {
        nextTime = todayPrayers.timeForPrayer(next);
      }

      // هـ) تحديث البيانات
      if (nextTime != null) {
        final diff = nextTime.difference(now);

        if (mounted) {
          setState(() {
            _nextPrayerName = _getPrayerArabicName(next);
            _nextPrayerTimeDisplay = DateFormat.jm('ar').format(nextTime!);
            _remainingTime = diff;
            _isLoading = false;
            _hasError = false;
          });

          _startTimer();
        }
      }
    } catch (e) {
      debugPrint("Error calculating prayer: $e");
      if (mounted) setState(() => _hasError = true);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        _calculateNextPrayer();
      }
    });
  }

  String _getPrayerArabicName(Prayer p) {
    switch (p) {
      case Prayer.fajr:
        return "الفجر";
      case Prayer.sunrise:
        return "الشروق";
      case Prayer.dhuhr:
        return "الظهر";
      case Prayer.asr:
        return "العصر";
      case Prayer.maghrib:
        return "المغرب";
      case Prayer.isha:
        return "العشاء";
      default:
        return "";
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "00:00:00";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
    final iconBgColor = isDark ? Colors.white10 : const Color(0xFFE8ECE9);

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
      child: _isLoading
          ? Center(child: CircularProgressIndicator(color: primaryTextColor))
          : _hasError
          ? Center(
              child: Text(
                "يرجى تحديد الموقع من صفحة الصلاة",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: secondaryTextColor,
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الصلاة القادمة",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),

                    // اسم الصلاة الحقيقي
                    Text(
                      _nextPrayerName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 4),

                    // وقت الصلاة الحقيقي
                    Text(
                      _nextPrayerTimeDisplay,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryTextColor,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.access_time_rounded,
                          color: primaryTextColor,
                          size: 30,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // العداد التنازلي الحقيقي (جوه كونتينر شيك)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        // نفس لون خلفية الأيقونة عشان التناسق
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${_formatDuration(_remainingTime)}",
                        style: TextStyle(
                          fontSize: 14, // صغرنا الخط سنة عشان الكونتينر
                          fontWeight: FontWeight.bold,
                          // اللون الأساسي عشان يبرز جوه الكونتينر
                          color: primaryTextColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
