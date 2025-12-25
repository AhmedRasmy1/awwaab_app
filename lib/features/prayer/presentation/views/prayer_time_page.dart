import 'package:adhan/adhan.dart';
import 'package:awwaab_app/core/utils/cashed_data_shared_preferences.dart';
import 'package:awwaab_app/core/utils/prayer_service.dart';
import 'package:awwaab_app/features/prayer/presentation/widgets/current_prayer_card.dart';
import 'package:awwaab_app/features/prayer/presentation/widgets/prayer_hedear_section.dart'; // تأكد من اسم الملف صح
import 'package:awwaab_app/features/prayer/presentation/widgets/prayer_remider_card.dart'; // تأكد من اسم الملف صح
import 'package:awwaab_app/features/prayer/presentation/widgets/prayer_time_list.dart'; // تأكد من اسم الملف صح
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  // 1. استدعاء السيرفيس
  final PrayerService _prayerService = PrayerService();

  // 2. متغيرات الحالة (State Variables)
  String _cityName = "جاري تحديد الموقع...";
  PrayerTimes? _prayerTimes;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // أول ما الصفحة تفتح، ابدأ هات البيانات
    _fetchPrayerData();
  }

  // دالة جلب البيانات (اللوجيك الرئيسي)
  Future<void> _fetchPrayerData() async {
    try {
      // أ) هات المكان (GPS)
      final position = await _prayerService.determinePosition();
      await CacheService.setData(key: 'cached_lat', value: position.latitude);
      await CacheService.setData(key: 'cached_lng', value: position.longitude);

      // ب) هات اسم المدينة
      final city = await _prayerService.getCityName(position);

      // ج) احسب المواقيت
      final times = _prayerService.calculatePrayerTimes(position);

      // د) تحديث الشاشة
      if (mounted) {
        setState(() {
          _cityName = city;
          _prayerTimes = times;
          _isLoading = false;
        });
      }
    } catch (e) {
      // لو حصل خطأ (مثلاً اللوكيشن مقفول)
      if (mounted) {
        setState(() {
          _error = "يرجى تفعيل خدمة الموقع وتجربة المحاولة مرة أخرى.";
          _isLoading = false;
        });
      }
    }
  }

  // دالة مساعدة لترجمة اسم الصلاة
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
        return "الفجر"; // لو خلصوا يبقى اللي عليها الدور الفجر
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // ==========================================
    // حالة التحميل (Loading State)
    // ==========================================
    if (_isLoading) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: const Center(
          child: CircularProgressIndicator(color: Color(0xFF1B4332)),
        ),
      );
    }

    // ==========================================
    // حالة الخطأ (Error State)
    // ==========================================
    if (_error != null) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_off_outlined,
                  size: 60,
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Cairo', fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => _isLoading = true);
                    _fetchPrayerData(); // حاول تاني
                  },
                  child: const Text(
                    "إعادة المحاولة",
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ==========================================
    // حالة النجاح (Success State) - عرض البيانات
    // ==========================================

    // تجهيز بيانات الكارت الحالي والقادم
    final formatter = DateFormat.jm('ar'); // تنسيق الوقت (مثلاً: ٥:٣٠ م)

    // الصلاة الحالية
    final currentP = _prayerTimes!.currentPrayer();
    // لو الوقت بعد العشاء، المكتبة بترجع none، فبنعرض العشاء كآخر صلاة
    final displayCurrent = currentP == Prayer.none ? Prayer.isha : currentP;

    // الصلاة القادمة
    final nextP = _prayerTimes!.nextPrayer();
    // لو nextP هي none (يعني خلصنا العشاء)، يبقى اللي عليها الدور الفجر
    final displayNext = nextP == Prayer.none ? Prayer.fajr : nextP;

    // وقت الصلاة القادمة (لو الفجر يبقى نجيبه من بكرة - بس للتبسيط هنعرض وقت فجر النهاردة مؤقتاً أو وقت الفجر القادم لو المكتبة ظبطته)
    // مكتبة adhan ذكية، لو طلبت timeForPrayer للفجر وهو عدا، بتجيب بتاع النهاردة.
    // للدقة في الكارت: مجرد عرض الوقت.

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: isSmallScreen ? 12 : 20,
          right: isSmallScreen ? 12 : 20,
          bottom: screenHeight * 0.15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. الهيدر (اسم المدينة الحقيقي)
            PrayerHeaderSection(cityName: _cityName),

            SizedBox(height: screenHeight * 0.02),

            // 2. الكارت الكبير (البيانات الحقيقية)
            CurrentPrayerCard(
              currentName: _getPrayerArabicName(displayCurrent),
              currentTime: formatter.format(
                _prayerTimes!.timeForPrayer(displayCurrent)!,
              ),
              nextName: _getPrayerArabicName(displayNext),
              nextTime: formatter.format(
                _prayerTimes!.timeForPrayer(displayNext)!,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // 3. القائمة (مررنا كائن المواقيت بالكامل)
            PrayerTimesList(prayerTimes: _prayerTimes!),

            SizedBox(height: screenHeight * 0.02),

            // 4. التذكير
            const PrayerReminderCard(),
          ],
        ),
      ),
    );
  }

  // فصلنا الـ AppBar عشان الكود يبقى أنظف
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "مواقيت الصلاة",
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
      ),
      centerTitle: true,

      actions: [
        IconButton(
          icon: const Icon(Icons.location_on_outlined, size: 24),
          onPressed: () {
            // ريفريش للموقع لو حابب
            setState(() => _isLoading = true);
            _fetchPrayerData();
          },
        ),
      ],
    );
  }
}
