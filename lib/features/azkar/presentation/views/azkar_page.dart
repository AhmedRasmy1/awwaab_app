import 'package:awwaab_app/features/azkar/data/azkar_model.dart';
import 'package:awwaab_app/features/azkar/data/data_loader_service.dart';
import 'package:awwaab_app/features/azkar/presentation/widgets/azkar_category_card.dart';
import 'package:awwaab_app/features/azkar/presentation/widgets/hadith_card.dart';
import 'package:awwaab_app/features/azkar/presentation/widgets/section_title.dart';
import 'package:flutter/material.dart';

class AzkarPage extends StatefulWidget {
  const AzkarPage({super.key});

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  late Future<List<AzkarCategoryModel>> _azkarFuture;

  @override
  void initState() {
    super.initState();
    _azkarFuture = DataLoaderService.loadAzkar();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF1B4332);
    final accentColor = const Color(0xFFC8B88A);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF9F9F9),
      appBar: _buildAppBar(context, isDark, primaryColor),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.only(
          left: isSmallScreen ? 12 : 20,
          right: isSmallScreen ? 12 : 20,
          bottom: 20, // 👈 مسافة صغيرة ومناسبة تحت
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. عنوان الأذكار
            SectionTitle(
              title: "الأذكار اليومية",
              icon: Icons.format_list_bulleted,
              color: primaryColor,
            ),

            SizedBox(height: screenHeight * 0.02),

            // 2. شبكة الأذكار (Grid)
            FutureBuilder<List<AzkarCategoryModel>>(
              future: _azkarFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(
                        color: Color(0xFF1B4332),
                      ),
                    ),
                  );
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return _buildErrorWidget();
                }

                final categories = snapshot.data!;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return AzkarCategoryCard(category: categories[index]);
                  },
                );
              },
            ),

            SizedBox(height: screenHeight * 0.03),

            // 3. قسم الأحاديث
            SectionTitle(
              title: "من هدي النبوة",
              icon: Icons.menu_book_rounded,
              color: accentColor,
            ),

            SizedBox(height: screenHeight * 0.02),

            // 4. كارت الأحاديث (واحد بس)
            const HadithCard(),

            // مساحة أمان تحت عشان السكرول
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // دالة بناء الـ AppBar مفصولة عشان الكود يبقى نضيف
  AppBar _buildAppBar(BuildContext context, bool isDark, Color primaryColor) {
    return AppBar(
      title: const Text(
        "الأذكار والأحاديث",
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
      ),
      centerTitle: true,
      backgroundColor: isDark ? Colors.transparent : Colors.white,
      elevation: 0,
      foregroundColor: isDark ? Colors.white : primaryColor,
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: const [
          Icon(Icons.error_outline, size: 40, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "لا توجد بيانات متاحة حالياً",
            style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
