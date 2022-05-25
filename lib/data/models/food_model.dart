class Food {
  final String name, id;
  final String? imageUrl, description;
  final List<dynamic> nutrients;

  Food({
    required this.id,
    required this.name,
    required this.nutrients,
    this.description,
    this.imageUrl
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['fdcId'].toString(),
      name: json['lowercaseDescription'] as String,
      nutrients: json['foodNutrients'] as List<dynamic>
    );
  }
  factory Food.fromJsonUPC(Map<String, dynamic> json) {
    return Food(
      id: json['code'].toString(),
      name: json['product']['generic_name'] ?? json['product']['product_name'],
      description: json['product']['product_name'] as String,
      nutrients: json['product']['nutriments'],
      imageUrl: json['product']['image_url'] as String
    );
  }
}
