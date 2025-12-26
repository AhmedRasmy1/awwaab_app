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
        backgroundColor: isDark ? Colors.transparent : Colors.white,
        foregroundColor: isDark ? Colors.white : primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
// كارت الذكر الذكي (محدث ليعرض الفضل والشرح)
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
    final isDone = _currentCount == _targetCount;
    final defaultBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final doneBgColor = isDark
        ? primaryColor.withOpacity(0.2)
        : const Color(0xFFE8F5E9);

    double progress = _targetCount > 0 ? _currentCount / _targetCount : 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isDone ? doneBgColor : defaultBgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
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
              fontFamily:
                  'AmiriQuran', // تأكد إن الفونت ده متعرف في pubspec.yaml
              fontSize: 20, // كبرنا الخط سنة عشان القراءة تكون أسهل
              height: 1.8, // وسعنا السطور عشان التشكيل
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF2D2D2D),
            ),
          ),

          // 2. الفضل (Description) - لو موجود نعرضه
          if (widget.azkarItem.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.azkarItem.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  color: isDark
                      ? Colors.white70
                      : const Color(0xFFC88A00), // لون دهبي غامق شوية
                ),
              ),
            ),
          ],

          const SizedBox(height: 20),

          // 3. الدائرة والعداد
          GestureDetector(
            onTap: _incrementCounter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 5, // تخنا الدايرة سنة
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 5,
                    color: primaryColor,
                    strokeCap: StrokeCap.round, // خلينا الحواف مدورة (أشيك)
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$_currentCount",
                      style: TextStyle(
                        fontSize: 26,
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

          // 4. الحالة النهائية والمصدر
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
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "✓",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "تم بحمد الله",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : primaryColor,
                  ),
                ),
              ],
            ),
          ] else ...[
            // عرض المصدر
            if (widget.azkarItem.reference.isNotEmpty)
              Text(
                widget.azkarItem.reference,
                textAlign: TextAlign.center,
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
