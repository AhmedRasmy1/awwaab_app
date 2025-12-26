class AzkarCategoryModel {
  final String category;
  final String image;
  final List<AzkarItemModel> array;

  AzkarCategoryModel({
    required this.category,
    required this.image,
    required this.array,
  });
}

class AzkarItemModel {
  final String text; // هتاخد قيمتها من zekr
  final int count;
  final String reference;
  final String description; // الوصف (الفضل)
  final String search; // 👈 ضفتلك ده عشان موجود في الملف (مفيد للبحث)

  AzkarItemModel({
    required this.text,
    required this.count,
    required this.reference,
    required this.description,
    required this.search,
  });

  factory AzkarItemModel.fromJson(Map<String, dynamic> json) {
    // 1. تأمين العداد (ممكن ييجي رقم أو نص)
    int parsedCount = 1;
    if (json['count'] is int) {
      parsedCount = json['count'];
    } else if (json['count'] is String) {
      parsedCount = int.tryParse(json['count']) ?? 1;
    }

    return AzkarItemModel(
      // 2. ربط المفاتيح (Keys) بمتغيرات التطبيق
      text: json['zekr'] ?? "", // ✅ zekr -> text
      count: parsedCount, // ✅ count -> count
      reference: json['reference'] ?? "", // ✅ reference -> reference
      description: json['description'] ?? "", // ✅ description -> description
      search: json['search'] ?? "", // ✅ search -> search
    );
  }
}
