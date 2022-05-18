class Food {
  final String name, id;
  final List<dynamic> nutrients;

  Food({
    required this.id,
    required this.name,
    required this.nutrients,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['fdcId'].toString(),
      name: json['lowercaseDescription'] as String,
      nutrients: json['foodNutrients'] as List<dynamic>
    );
  }
}
