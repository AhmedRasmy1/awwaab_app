import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:awwaab_app/core/utils/cashed_data_shared_preferences.dart';

class PrayerTimesList extends StatefulWidget {
  final PrayerTimes prayerTimes;

  const PrayerTimesList({super.key, required this.prayerTimes});

  @override
  State<PrayerTimesList> createState() => _PrayerTimesListState();
}

class _PrayerTimesListState extends State<PrayerTimesList> {
  late List<Map<String, dynamic>> _prayers;

  @override
  void initState() {
    super.initState();
    _setupPrayersList();
    _loadPrayerStates(); // 1. نحمل الحالات أول ما الصفحة تفتح
  }

  void _setupPrayersList() {
    final pt = widget.prayerTimes;
    final current = pt.currentPrayer();
    final formatter = DateFormat.jm('ar');

    _prayers = [
      {
        'id': 1,
        'name': 'الفجر',
        'time': formatter.format(pt.fajr),
        'isPrayed': false,
        'isCurrent': current == Prayer.fajr,
      },
      {
        'id': 2,
        'name': 'الشروق',
        'time': formatter.format(pt.sunrise),
        'isPrayed': false,
        'isCurrent': false, // الشروق لا يعتبر صلاة حالية في Adhan
        'isSunrise': true,
      },
      {
        'id': 3,
        'name': 'الظهر',
        'time': formatter.format(pt.dhuhr),
        'isPrayed': false,
        'isCurrent': current == Prayer.dhuhr,
      },
      {
        'id': 4,
        'name': 'العصر',
        'time': formatter.format(pt.asr),
        'isPrayed': false,
        'isCurrent': current == Prayer.asr,
      },
      {
        'id': 5,
        'name': 'المغرب',
        'time': formatter.format(pt.maghrib),
        'isPrayed': false,
        'isCurrent': current == Prayer.maghrib,
      },
      {
        'id': 6,
        'name': 'العشاء',
        'time': formatter.format(pt.isha),
        'isPrayed': false,
        'isCurrent': current == Prayer.isha,
      },
    ];
  }

  // ============================================================
  // 💾 منطق الحفظ والاسترجاع (CacheService)
  // ============================================================

  String _getStorageKey(String prayerName) {
    // المفتاح عبارة عن: التاريخ_اسم الصلاة
    // عشان لما اليوم يتغير، التاريخ يتغير فالبيانات ترجع فاضية (تتصفر)
    final today = DateTime.now().toIso8601String().split('T')[0];
    return '${today}_$prayerName';
  }

  void _loadPrayerStates() {
    setState(() {
      for (var prayer in _prayers) {
        if (prayer['isSunrise'] == true) continue;

        final key = _getStorageKey(prayer['name']);

        // استرجاع البيانات من CacheService
        // لو مفيش داتا (null) بنعتبرها false
        prayer['isPrayed'] = CacheService.getData(key: key) ?? false;
      }
    });
  }

  Future<void> _savePrayerState(int index, bool value) async {
    final key = _getStorageKey(_prayers[index]['name']);
    // حفظ البيانات باستخدام CacheService
    await CacheService.setData(key: key, value: value);
  }

  // ============================================================

  double get _progress {
    int completed = _prayers
        .where((p) => p['isPrayed'] == true && p['isSunrise'] != true)
        .length;
    return completed / 5.0;
  }

  void _togglePrayer(int index) {
    if (_prayers[index]['isSunrise'] == true) return;

    setState(() {
      _prayers[index]['isPrayed'] = !_prayers[index]['isPrayed'];
    });

    // حفظ الحالة الجديدة
    _savePrayerState(index, _prayers[index]['isPrayed']);

    if (_progress == 1.0) {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF1B4332),
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                "ما شاء الله!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Color(0xFF1B4332),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "أتممت صلواتك اليوم\nتقبل الله منك وجعلها في ميزان حسناتك",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Cairo',
                  height: 1.6,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "اللهم آمين",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // الألوان
    final activeColor = const Color(0xFF1B4332); // الأخضر الغامق
    final activeNumberBg = const Color(0xFF143024); // أخضر أغمق للرقم
    final defaultNumberBg = Colors.grey.shade200;

    return Column(
      children: [
        // 1. شريط التقدم
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "سجل صلواتك اليوم",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    "${(_progress * 100).toInt()}%",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: activeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: isDark
                      ? Colors.white24
                      : Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(activeColor),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "جميع الأوقات",
            style: TextStyle(
              fontFamily: 'Cairo',
              color: isDark ? Colors.white70 : Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // 2. قائمة الصلوات (Loop)
        ...List.generate(_prayers.length, (index) {
          final prayer = _prayers[index];
          final isCurrent = prayer['isCurrent'];
          final isPrayed = prayer['isPrayed'];
          final isSunrise = prayer['isSunrise'] == true;
          final int prayerId = prayer['id'];

          // ========================
          // 🎨 ضبط الألوان (اللوجيك الجديد)
          // ========================

          // 1. الخلفية
          // (أخضر فقط لو هي الحالية وأنت لسه مصليتهاش)
          Color bgColor;
          if (isCurrent && !isPrayed) {
            bgColor = activeColor;
          } else {
            bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
          }

          // 2. البوردر
          Color borderColor;
          if (isCurrent && !isPrayed) {
            borderColor = Colors.transparent;
          } else {
            borderColor = isDark ? Colors.white12 : Colors.grey.shade200;
          }

          // 3. النصوص
          // (لو صليتها تبقى رمادي - Disabled Look)
          // (لو الحالية ولسه مصليتهاش تبقى أبيض عشان الخلفية خضراء)
          Color textColor;
          if (isCurrent && !isPrayed) {
            textColor = Colors.white;
          } else if (isPrayed) {
            textColor = Colors.grey; // رمادي للمنتهية
          } else {
            textColor = isDark ? Colors.white : Colors.black87;
          }

          return GestureDetector(
            onTap: () => _togglePrayer(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 1.5),
                // شادو فقط للصلاة الحالية النشطة
                boxShadow: (isCurrent && !isPrayed)
                    ? [
                        BoxShadow(
                          color: activeColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  // 1. الدايرة (الرقم أو الصح)
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // لون الخلفية للدايرة
                      color: (isCurrent && !isPrayed)
                          ? activeNumberBg // أخضر غامق لو الحالية
                          : (isPrayed
                                ? Colors.transparent
                                : defaultNumberBg), // شفاف لو صليتها
                      border: isPrayed
                          ? Border.all(color: Colors.grey.shade300)
                          : null,
                    ),
                    child: isPrayed
                        ? const Icon(Icons.check, size: 18, color: Colors.grey)
                        : Text(
                            "$prayerId",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              // الرقم أبيض لو الحالية النشطة، غير كده أسود
                              color: (isCurrent && !isPrayed)
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                  ),

                  const SizedBox(width: 15),

                  // 2. الاسم
                  Text(
                    prayer['name'],
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      // الخط عريض لو الحالية النشطة
                      fontWeight: (isCurrent && !isPrayed)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),

                  const Spacer(),

                  // 3. الوقت
                  SizedBox(
                    width: 70,
                    child: Text(
                      prayer['time'],
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
