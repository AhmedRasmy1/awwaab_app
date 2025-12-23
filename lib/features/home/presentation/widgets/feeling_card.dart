import 'package:flutter/material.dart';
// تأكد من وجود هذا السطر لو هتستخدم أيقونة اليدين بتاعت الدعاء
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class FeelingsSection extends StatefulWidget {
  const FeelingsSection({super.key});

  @override
  State<FeelingsSection> createState() => _FeelingsSectionState();
}

class _FeelingsSectionState extends State<FeelingsSection> {
  int? _selectedIndex;
  late List<int> _duaIndices;

  @override
  void initState() {
    super.initState();
    _duaIndices = List.generate(feelingsData.length, (index) => 0);
  }

  // الداتا (تم تغيير 'icon' ليقبل IconData بدلاً من String)
  final List<Map<String, dynamic>> feelingsData = [
    {
      'label': 'حزين',
      // استخدمنا أيقونات دائرية ناعمة (Rounded)
      'icon': Icons.sentiment_dissatisfied_rounded,
      'duas': [
        "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ، وَغَلَبَةِ الرِّجَالِ.",
        "لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ.",
        "اللَّهُمَّ رَحْمَتَكَ أَرْجُو فَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ، وَأَصْلِحْ لِي شَأْنِي كُلَّهُ لَا إِلَهَ إِلَّا أَنْتَ.",
        "اللهُ اللهُ رَبِّي لَا أُشْرِكُ بِهِ شَيْئًا.",
        "يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ.",
      ],
    },
    {
      'label': 'سعيد',
      'icon': Icons.sentiment_satisfied_alt_rounded,
      'duas': [
        "الْحَمْدُ لِلَّهِ الَّذِي بِنِعْمَتِهِ تَتِمُّ الصَّالِحَاتُ.",
        "اللَّهُمَّ لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ وَعَظِيمِ سُلْطَانِكَ.",
        "الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ.",
        "اللَّهُمَّ بَارِكْ لَنَا فِيمَا أَعْطَيْتَ وَزِدْنَا مِنْ فَضْلِكَ.",
        "رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَى وَالِدَيَّ.",
      ],
    },
    {
      'label': 'قلق',
      'icon': Icons
          .help_outline_rounded, // علامة استفهام دائرية تعبر عن الحيرة والقلق
      'duas': [
        "حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ.",
        "اللَّهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلًا، وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلًا.",
        "اللَّهُمَّ اكْفِنِيهِمْ بِمَا شِئْتَ.",
        "رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي.",
        "لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ.",
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ نَفْسًا بِكَ مُطْمَئِنَّةً، تُؤْمِنُ بِالْقَاءِكَ، وَتَرْضَى بِقَضَائِكَ، وَتَقْنَعُ بِعَطَائِكَ.",
      ],
    },
    {
      'label': 'غاضب',
      'icon': Icons.mood_bad_rounded,
      'duas': [
        "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ.",
        "اللَّهُمَّ اغْفِرْ لِي ذَنْبِي، وَأَذْهِبْ غَيْظَ قَلْبِي، وَأَجِرْنِي مِنَ الشَّيْطَانِ.",
        "لَا إِلَهَ إِلَّا اللَّهُ الْحَلِيمُ الْكَرِيمُ.",
        "أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ وَأَتُوبُ إِلَيْهِ.",
        "رَبَّنَا اغْفِرْ لَنَا وَلِإِخْوَانِنَا الَّذِينَ سَبَقُونَا بِالْإِيمَانِ وَلَا تَجْعَلْ فِي قُلُوبِنَا غِلًّا لِلَّذِينَ آمَنُوا.",
      ],
    },
    {
      'label': 'شاكر',
      'icon': FlutterIslamicIcons.prayer,
      'duas': [
        "رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ.",
        "اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ.",
        "الْحَمْدُ لِلَّهِ عَلَى كُلِّ حَالٍ.",
        "اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ.",
        "الْحَمْدُ لِلَّهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ.",
      ],
    },
    {
      'label': 'متعب',
      'icon': Icons.sick_outlined,
      'duas': [
        "اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ اشْفِ أَنْتَ الشَّافِي لَا شِفَاءَ إِلَّا شِفَاؤُكَ شِفَاءً لَا يُغَادِرُ سَقَمًا.",
        "بِسْمِ اللَّهِ (ثَلَاثًا)، أَعُوذُ بِاللَّهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ (سَبْعَ مَرَّاتٍ).",
        "أَنِّي مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرَّاحِمِينَ.",
        "اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ.",
        "حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectedColor = const Color(0xFF1F3C2E);
    final unselectedBgColor = isDark ? Colors.white10 : Colors.white;
    final cardBgColor = isDark
        ? const Color(0xFF242826)
        : const Color(0xFFF9F5EB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. العنوان + الأيقونة
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.favorite_border_rounded,
                size: 18,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                "بمَ تشعر الآن؟",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 2. قائمة المشاعر
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: List.generate(feelingsData.length, (index) {
              final isSelected = _selectedIndex == index;
              final feeling = feelingsData[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedIndex == index) {
                      _selectedIndex = null;
                      _duaIndices[index] =
                          (_duaIndices[index] + 1) %
                          (feeling['duas'] as List).length;
                    } else {
                      _selectedIndex = index;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(left: 12),
                  width: 75,
                  height: 90,
                  decoration: BoxDecoration(
                    color: isSelected ? selectedColor : unselectedBgColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      if (!isSelected && !isDark)
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // التعديل هنا: استخدام Icon بدلاً من Text
                      Icon(
                        feeling['icon'] as IconData,
                        size: 32, // حجم مناسب للأيقونة
                        // لون الأيقونة يتغير مع التحديد زي النص بالظبط
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white70 : Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feeling['label'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? Colors.white70 : Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),

        // 3. كارت الدعاء (بدون تعديل في اللوجيك)
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: _selectedIndex == null
              ? const SizedBox.shrink()
              : Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Text(
                        feelingsData[_selectedIndex!]['duas'][_duaIndices[_selectedIndex!]],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1F3C2E),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            int currentIndex = _selectedIndex!;
                            _duaIndices[currentIndex] =
                                (_duaIndices[currentIndex] + 1) %
                                (feelingsData[currentIndex]['duas'] as List)
                                    .length;
                            _selectedIndex = null;
                          });
                        },
                        child: Text(
                          "إخفاء",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
