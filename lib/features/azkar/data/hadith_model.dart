class HadithModel {
  final int id;
  final String key;
  final String name;
  final String text;
  final String explanation;

  HadithModel({
    required this.id,
    required this.key,
    required this.name,
    required this.text,
    required this.explanation,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      id: json['id'] ?? 0,
      key: json['key'] ?? "",
      name: json['name'] ?? "",
      text: json['text'] ?? "",
      explanation: json['explanation'] ?? "",
    );
  }
}
