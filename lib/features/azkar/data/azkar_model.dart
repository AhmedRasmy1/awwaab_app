class AzkarCategoryModel {
  final String category;
  final String image; // ممكن نستخدمها عشان نحط أيقونة لكل قسم
  final List<AzkarItemModel> array;

  AzkarCategoryModel({
    required this.category,
    this.image = "",
    required this.array,
  });

  factory AzkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AzkarCategoryModel(
      category: json['category'] ?? "",
      image: json['image'] ?? "",
      array: (json['array'] as List)
          .map((e) => AzkarItemModel.fromJson(e))
          .toList(),
    );
  }
}

class AzkarItemModel {
  final String text;
  final int count;
  final String reference;

  AzkarItemModel({
    required this.text,
    required this.count,
    required this.reference,
  });

  factory AzkarItemModel.fromJson(Map<String, dynamic> json) {
    return AzkarItemModel(
      text: json['text'] ?? "",
      count: json['count'] ?? 1,
      reference: json['reference'] ?? "",
    );
  }
}
