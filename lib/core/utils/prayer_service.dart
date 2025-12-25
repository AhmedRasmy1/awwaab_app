import 'package:adhan/adhan.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class PrayerService {
  // 1. تحديد الموقع
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('خدمة الموقع غير مفعلة');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('تم رفض إذن الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('تم رفض إذن الموقع بشكل دائم');
    }

    return await Geolocator.getCurrentPosition();
  }

  // 2. اسم المدينة
  Future<String> getCityName(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // بنرجع (المدينة، المحافظة، الدولة)
        return "${place.locality ?? place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      }
      return "موقع غير معروف";
    } catch (e) {
      return "غير قادر على تحديد المدينة";
    }
  }

  // 3. حساب المواقيت (المصنع)
  PrayerTimes calculatePrayerTimes(Position position) {
    final myCoordinates = Coordinates(position.latitude, position.longitude);
    // الطريقة المصرية + المذهب الشافعي (الجمهور)
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final today = DateComponents.from(DateTime.now());
    return PrayerTimes(myCoordinates, today, params);
  }
}
