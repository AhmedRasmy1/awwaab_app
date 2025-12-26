import 'package:flutter/material.dart';
import 'package:awwaab_app/features/azkar/data/azkar_model.dart';

class AzkarDetailsPage extends StatelessWidget {
  final AzkarCategoryModel category;

  const AzkarDetailsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF1B4332);
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF9F9F9);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          category.category,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: category.array.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return AzkarCardItem(azkarItem: category.array[index]);
        },
      ),
    );
  }
}

// ---------------------------------------------------------
// كارت الذكر الذكي (بيتغير لونه لما يخلص)
// ---------------------------------------------------------
class AzkarCardItem extends StatefulWidget {
  final AzkarItemModel azkarItem;

  const AzkarCardItem({super.key, required this.azkarItem});

  @override
  State<AzkarCardItem> createState() => _AzkarCardItemState();
}

class _AzkarCardItemState extends State<AzkarCardItem>
    with AutomaticKeepAliveClientMixin {
  late int _currentCount;
  late int _targetCount;

  @override
  void initState() {
    super.initState();
    _targetCount = widget.azkarItem.count;
    _currentCount = 0;
  }

  void _incrementCounter() {
    if (_currentCount < _targetCount) {
      setState(() {
        _currentCount++;
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _currentCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF1B4332);

    // هل خلصنا عد؟
    final isDone = _currentCount == _targetCount;

    // 🎨 ألوان الكارت العادية
    final defaultBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    // 🎨 ألوان الكارت لما يخلص (Highight Color)
    final doneBgColor = isDark
        ? primaryColor.withOpacity(0.2) // أخضر غامق شفاف في النايت مود
        : const Color(0xFFE8F5E9); // أخضر فاتح جداً في اللايت مود

    // حساب نسبة التقدم
    double progress = _targetCount > 0 ? _currentCount / _targetCount : 0;

    // استخدمنا AnimatedContainer عشان تغيير اللون يكون ناعم
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // سرعة التحول
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isDone ? doneBgColor : defaultBgColor, // 👈 هنا تغيير اللون
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          // 👈 لو خلص، البرواز يبقى أخضر، لو لسه يبقى رمادي خفيف
          color: isDone
              ? primaryColor.withOpacity(0.5)
              : (isDark ? Colors.white10 : const Color(0xFFF0F0F0)),
          width: isDone ? 1.5 : 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 1. نص الذكر
          Text(
            widget.azkarItem.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 18,
              height: 1.6,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF2D2D2D),
            ),
          ),

          const SizedBox(height: 20),

          // 2. الدائرة والعداد
          GestureDetector(
            onTap: _incrementCounter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // الدائرة الخلفية
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 4,
                    // لو خلصنا بنخلي الدايرة الخلفية شفافة شوية عشان متبقاش شاذة
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                  ),
                ),
                // دائرة التقدم
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4,
                    color: primaryColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                // الرقم جوه الدائرة
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$_currentCount",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        height: 1,
                      ),
                    ),
                    Text(
                      "من $_targetCount",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Cairo',
                        color: isDark ? Colors.white54 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. الحالة النهائية
          if (isDone) ...[
            TextButton.icon(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text(
                "إعادة تعيين",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey, // لون الزرار رمادي عشان ميزغللش
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "✓",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  "تم بحمد الله",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ] else ...[
            Text(
              widget.azkarItem.reference.isEmpty
                  ? "حديث شريف"
                  : widget.azkarItem.reference,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
